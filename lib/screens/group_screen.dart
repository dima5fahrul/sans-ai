import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sansai_mobile/components/common_form.dart';
import 'package:sansai_mobile/components/custom_button.dart';
import 'package:sansai_mobile/screens/detail_group_screen.dart';
import 'package:sansai_mobile/shared/my_colors.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();

  static _GroupScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_GroupScreenState>();
}

class _GroupScreenState extends State<GroupScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> groupList = [];

  String? _getCurrentUserEmail() {
    User? user = _auth.currentUser;
    return user?.email;
  }

  Future<List<Map<String, dynamic>>> _getGroup() async {
    String? email = await _getCurrentUserEmail();
    List<Map<String, dynamic>> groupList = [];

    if (email != null) {
      var querySnapshot = await _db
          .collection('groups')
          .where('email_list', arrayContains: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          groupList.add(doc.data());
        }
      }
    }

    return groupList;
  }

  Future<void> setGroupList() async {
    var value = await _getGroup();
    setState(() => groupList = value);
  }

  Future<void> _joinGroup() async {
    if (codeController.text.isNotEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Dialog(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: Center(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(color: Colors.white)))));

      await _db
          .collection('groups')
          .where('code', isEqualTo: codeController.text)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          var group = value.docs.first.data();
          var email = _getCurrentUserEmail();

          await _db.collection('groups').doc(value.docs.first.id).update({
            'email_list': FieldValue.arrayUnion([email])
          }).then((value) async {
            await _db
                .collection('users')
                .where('email', isEqualTo: email)
                .get()
                .then((value) async {
              if (value.docs.isNotEmpty) {
                await _db.collection('users').doc(value.docs.first.id).update({
                  'group_joined_list': FieldValue.arrayUnion([
                    {'name': group['name'], 'code': group['code']}
                  ])
                }).then((value) async {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Berhasil bergabung dengan grup')));
                  await setGroupList();
                });
              }
            });
          });

          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Kode grup tidak ditemukan, silahkan coba lagi')));
          Navigator.pop(context);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kode grup tidak boleh kosong')));
    }
  }

  @override
  void initState() {
    super.initState();
    setGroupList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 120,
        elevation: 1,
        shadowColor: Colors.black,
        surfaceTintColor: const Color(0xFFF8F8F8),
        backgroundColor: const Color(0xFFF8F8F8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Grup',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
                GestureDetector(
                    onTap: () {}, child: const Icon(Icons.filter_list)),
              ],
            ),
            const SizedBox(height: 10),
            CommonForm(
                title: 'Cari grup yang anda inginkan',
                textController: searchController,
                height: 38,
                prefixIcon: const Icon(Icons.search),
                fillColor: const Color(0xFFE9E7E7))
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await setGroupList(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                      flex: 2,
                      child: CommonForm(
                          title: 'Masukkan Kode',
                          textController: codeController,
                          borderColor: Colors.grey,
                          height: 42)),
                  const SizedBox(width: 20),
                  Flexible(
                      flex: 1,
                      child: CustomButton(
                          text: 'Gabung',
                          onPressed: () => _joinGroup(),
                          width: MediaQuery.of(context).size.width,
                          height: 42)),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: _getGroup(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: MyColors.primaryColor));
                    } else {
                      if (groupList.isEmpty) {
                        return Center(
                            child: Column(
                          children: [
                            const Text('Anda belum memiliki grup'),
                            const SizedBox(height: 10),
                            GestureDetector(
                                onTap: () async => await setGroupList(),
                                child: const Icon(Icons.refresh)),
                          ],
                        ));
                      }

                      return ListView.separated(
                          shrinkWrap: true,
                          itemCount: groupList.length,
                          itemBuilder: (context, index) {
                            var group = groupList[index];
                            Timestamp createdDate = group['created_at'];
                            var formattedDate =
                                DateFormat('dd MMMM yyyy', 'id_ID')
                                    .format(createdDate.toDate())
                                    .toString();

                            return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: const Color(0xFFD8D8D8),
                                        width: 1)),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DetailGroupScreen())),
                                    child: Ink(
                                      color: Colors.transparent,
                                      child: ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFE9E7E7),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Icon(Icons.group,
                                                color: Colors.black),
                                          ),
                                          title: Text(group['name'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black)),
                                          subtitle: Text(
                                              'Dibuat pada $formattedDate',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          trailing: const Icon(
                                              Icons.arrow_forward_ios)),
                                    ),
                                  ),
                                ));
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

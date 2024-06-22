import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sansai_mobile/components/common_form.dart';
import 'package:uuid/uuid.dart';

import '../components/custom_button.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  var groupNameController = TextEditingController();
  var emailMemberController = TextEditingController();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? name;
  List emailList = [];
  String? code;

  void _addEmail() async {
    var currentEmail = _getCurrentUserEmail();

    await _db
        .collection('users')
        .where('email', isEqualTo: emailMemberController.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (!emailList.contains(emailMemberController.text) &&
            emailMemberController.text != currentEmail) {
          setState(() => emailList.add(emailMemberController.text));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email tidak ditemukan, silahkan coba lagi')));
      }
    });
  }

  Future<void> _updateGroupForUser(String email) async {
    try {
      var querySnapshot =
          await _db.collection('users').where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await _db.collection('users').doc(doc.id).update({
            'group_joined_list': FieldValue.arrayUnion([
              {'name': name, 'code': code}
            ])
          });
        }
      }
    } catch (e) {
      print('Error updating group: $e');
    }
  }

  String? _getCurrentUserEmail() {
    User? user = _auth.currentUser;
    return user?.email;
  }

  Future<void> _createGroup() async {
    name = groupNameController.text;
    code = const Uuid().v4().substring(0, 6).toUpperCase();
    var id = const Uuid().v4();

    try {
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

      await _db.collection('groups').doc(id).set({
        'id': id,
        'name': name,
        'code': code,
        'created_by': _getCurrentUserEmail(),
        'created_at': DateTime.now(),
        'email_list': emailList,
      });

      for (var email in emailList) {
        await _updateGroupForUser(email);
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Grup berhasil dibuat')));
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Gagal membuat grup, silahkan coba lagi')));
    }
  }

  @override
  void initState() {
    super.initState();
    emailList.add(_getCurrentUserEmail()!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.black,
          title: Text('Buat Grup',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w700)),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context))),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF8F8F8),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFFD8D8D8), width: 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Nama Grup',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                        const SizedBox(height: 10),
                        CommonForm(
                            title: 'Masukkan Nama Grup',
                            textController: groupNameController,
                            borderColor: const Color(0xFFD8D8D8)),
                        const SizedBox(height: 20),
                        Text('Email Member',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: CommonForm(
                                    title: 'Masukkan Email Member',
                                    textController: emailMemberController,
                                    borderColor: const Color(0xFFD8D8D8))),
                            const SizedBox(width: 10),
                            Expanded(
                                flex: 1,
                                child: CustomButton(
                                    text: 'Invite',
                                    onPressed: () => _addEmail(),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 40))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Invited Member',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.black)),
                  const SizedBox(height: 10),
                  if (emailList.isNotEmpty)
                    ListView.builder(
                      itemCount: emailList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(emailList[index]),
                          trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  setState(() => emailList.removeAt(index))),
                        );
                      },
                    ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomButton(
                      text: 'Buat',
                      onPressed: () async => await _createGroup(),
                      width: MediaQuery.of(context).size.width,
                      boldText: true,
                      height: 50))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sansai_mobile/components/custom_button.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut() async {
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
    await _auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text('My Account',
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.fromBorderSide(
                            BorderSide(color: Color(0xFFD8D8D8), width: 2))),
                    child: Center(
                      child: Text('MN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Mochamad Nauval Azhar',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text('dimasfahrul',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  CustomButton(
                      text: 'Edit Profile',
                      onPressed: () {},
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40),
                  const SizedBox(height: 20),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                              title: Text('History',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 16)),
                          const Divider(
                              height: 1,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16),
                          ListTile(
                              title: Text('Device',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 16)),
                          const Divider(
                              height: 1,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16),
                          ListTile(
                              title: Text('Setting',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 16)),
                          const Divider(
                              height: 1,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16),
                          ListTile(
                              title: Text('Help',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 16)),
                        ],
                      )),
                  const SizedBox(height: 30),
                  GestureDetector(
                      onTap: () => _signOut(),
                      child: Text('Sign Out',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold))),
                  const SizedBox(height: 8),
                  Text('Version 1.1',
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
            ),
          )),
    );
  }
}

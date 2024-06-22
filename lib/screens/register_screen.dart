import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sansai_mobile/screens/navbar_view.dart';

import '../components/common_button.dart';
import '../components/common_form.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void _signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      _addUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _addUser() {
    CollectionReference users = _db.collection('users');

    return users.add({
      'name': nameController.text,
      'email': emailController.text,
    }).then((value) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Dialog(
              backgroundColor: Colors.transparent,
              child: Center(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(color: Colors.white)))));
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Added Successfully')));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const NavbarView()));
      debugPrint("User Added");
    }).catchError((error) {
      debugPrint("Failed to add user: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color(0xFFF8F8F8),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/logo.png', height: 56),
              const SizedBox(height: 20),
              Text('Sign Up',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Daftar ke akun sobat damai',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey, fontWeight: FontWeight.w500)),
              const SizedBox(height: 20),
              CommonForm(
                  title: 'Input your name', textController: nameController),
              const SizedBox(height: 20),
              CommonForm(
                  title: 'Input your email', textController: emailController),
              const SizedBox(height: 20),
              CommonForm(
                  title: 'Input your password',
                  textController: passwordController,
                  obscureText: true),
              const SizedBox(height: 20),
              CommonButton(
                  onPressed: emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty
                      ? () => _signUp()
                      : null,
                  text: 'Register Now'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ',
                      style: Theme.of(context).textTheme.bodyLarge),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                    },
                    child: Text('Login',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sansai_mobile/components/common_button.dart';
import 'package:sansai_mobile/components/common_form.dart';
import 'package:sansai_mobile/screens/navbar_view.dart';
import 'package:sansai_mobile/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void _login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login Successfully')));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const NavbarView()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text('Login',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Login ke akun sobat damai',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey, fontWeight: FontWeight.w500)),
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
                      ? () =>
                          _login(emailController.text, passwordController.text)
                      : null,
                  text: 'Login Now'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Kamu belum punya akun? ',
                      style: Theme.of(context).textTheme.bodyMedium),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen())),
                    child: Text('Sign up now',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
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

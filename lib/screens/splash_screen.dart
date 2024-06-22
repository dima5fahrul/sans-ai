import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sansai_mobile/screens/navbar_view.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _checkUser() {
    final firebaseAuth = FirebaseAuth.instance.currentUser;

    Future.delayed(
        const Duration(seconds: 3),
        () => firebaseAuth != null
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const NavbarView()))
            : Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const OnboardingScreen())));
  }

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            const SizedBox(height: 10),
            Text('SansAI',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

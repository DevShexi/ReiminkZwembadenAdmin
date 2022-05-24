import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/data/constants/colors/colors.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/landing_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  Future<void> checkEmailVerified() async {
    if (FirebaseAuth.instance.currentUser != null) {
      User user = FirebaseAuth.instance.currentUser!;
      await user.reload();
      if (user.emailVerified) {
        timer.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LandingPage(),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication Required for this action!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: AppColors.blue,
            size: 54,
          ),
          const SizedBox(
            height: 34,
          ),
          const Text(
            "Verification Required!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: AppColors.blue,
            ),
          ),
          const SizedBox(
            height: 34,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              "Please verify your email by clicking on the verification link that we have sent to ${FirebaseAuth.instance.currentUser!.email}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

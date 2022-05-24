import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/data/constants/colors/colors.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: Text("Landing Page"),
      ),
    );
  }
}

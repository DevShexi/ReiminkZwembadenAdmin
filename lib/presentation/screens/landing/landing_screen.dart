import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/home_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

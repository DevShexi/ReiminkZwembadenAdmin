import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reimink_zwembaden_admin/DI/Injector.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/firebase_options.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/auth/login_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/auth/register_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/home_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/landing/landing_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/auth/verifyEmail/verify_email_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Injector.setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reimink Zwembaden Admin',
      routes: {
        PagePath.login: (context) => const LoginScreen(),
        PagePath.register: (context) => const RegisterScreen(),
        PagePath.verifyEmail: (context) => const VerifyEmailScreen(),
        PagePath.landingPage: (context) => const LandingPage(),
      },
      theme: AppTheme.light(),
      // home: const HomeScreen(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          );
        } else if (snapshot.hasData && !snapshot.data!.emailVerified) {
          return const VerifyEmailScreen(); // return the verify Email screen here.
        } else if (snapshot.hasData && snapshot.data!.emailVerified) {
          debugPrint("--------- Redirecting Authenticated User ----------");
          return const LandingPage(); //Return the landing page where the authorized user will land when the app launches
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something Went wrong"),
          );
        }
        return const LoginScreen(); // Return the screen where the UnAuthenticated user will land when the app launches.
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/DI/Injector.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/firebase_options.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/auth/login_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/auth/register_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/clients/clients_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/settings/add_sensor_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/settings/sensors_listing_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/landing/landing_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/auth/verifyEmail/verify_email_screen.dart';
import 'presentation/screens/home/clients/pools/add_pool_screen.dart';
import 'presentation/screens/home/clients/pools/pools_listing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Injector.setUpLocator();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
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
        PagePath.poolsListing: (context) => const PoolsListingScreen(),
        PagePath.addPool: (context) => const AddPoolScreen(),
        PagePath.addSensor: (context) => const AddSensorScreen(),
        PagePath.clients: (context) => const ClientsScreen(),
        PagePath.sensors: (context) => const SensorsListingScreen(),
      },
      theme: AppTheme.light(),
      // home: const HomeScreen(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
          return const LandingPage();
          //Return the landing page where the authorized user will land when the app launches
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

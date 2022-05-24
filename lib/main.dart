import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:reimink_zwembaden_admin/firebase_options.dart';
import 'package:reimink_zwembaden_admin/serviceLocator/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: 'Reimink Zwembaden Admin',
        routes: {},
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
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
          return Container(); // return the verify Email screen here.
        } else if (snapshot.hasData && snapshot.data!.emailVerified) {
          return Container(); //Return the landing page where the authorized user will land when the app launches
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something Went wrong"),
          );
        }
        return Container(); // Return the screen where the UnAuthenticated user will land when the app launches.
      },
    );
  }
}

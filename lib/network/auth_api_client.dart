import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RegisterationState {
  registerationError,
  successful,
  weakPassword,
  emailAlreadyExists,
  unregistered
}
enum LoginState {
  userNotFound,
  wrongPassword,
  success,
  notLoggedIn,
}

class AuthController {
  String? get userId {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.uid;
    } else {
      return null;
    }
  }

  Future<RegisterationState> registerWithEmailAndPassword(
      {required String userEmail, required String userPassword}) async {
    RegisterationState registerState = RegisterationState.unregistered;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
      registerState = RegisterationState.successful;
      final String _uid = userCredential.user!.uid;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("uid", _uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        registerState = RegisterationState.weakPassword;
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        registerState = RegisterationState.emailAlreadyExists;
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      registerState = RegisterationState.registerationError;
      debugPrint(
        e.toString(),
      );
    }
    return registerState;
  }

  Future<LoginState> loginWithEmailPassword(
      String email, String password) async {
    LoginState _loginState = LoginState.notLoggedIn;
    try {
      UserCredential userCredentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("uid", userCredentials.user!.uid);
      prefs.setBool("emailLogin", true);
      _loginState = LoginState.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _loginState = LoginState.userNotFound;
        debugPrint('No User Found for $email.');
      } else if (e.code == 'wrong-password') {
        _loginState = LoginState.wrongPassword;
        debugPrint('Your password is incorrect');
      }
    } catch (e) {
      debugPrint(
        e.toString(),
      );
      _loginState = LoginState.notLoggedIn;
    }
    return _loginState;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // singletonMqttInstance().client!.disconnect();
    prefs.clear();
    debugPrint('Logged Out');
  }

  Future<bool> forgetPassword(String email) async {
    bool status = false;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      debugPrint("Password Reset Email was sent to $email");
      status = true;
    } catch (e) {
      debugPrint("Exception Caught while Requesting Forget Password: $e");
      status = false;
    }
    return status;
  }
}

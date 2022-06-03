import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:reimink_zwembaden_admin/data/models/network/network_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ApiClient {
  Future<LoginResponse> login(AuthRequest loginRequest);
  Future<RegisterResponse> register(AuthRequest loginRequest);
  Future<bool> forgotPassword(String email);
  Future? logout();
}

class ApiClientImpl implements ApiClient {
  @override
  Future<LoginResponse> login(AuthRequest loginRequest) async {
    final String email = loginRequest.email.trim();
    final String password = loginRequest.password.trim();
    LoginState _loginState = LoginState.notLoggedIn;
    try {
      UserCredential userCredentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(
          "--------- At this time, User is already logged In ----------");
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
    return LoginResponse(loginState: _loginState);
  }

  @override
  Future<RegisterResponse> register(AuthRequest loginRequest) async {
    final String email = loginRequest.email;
    final String password = loginRequest.password;
    RegisterationState registerState = RegisterationState.unregistered;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
    return RegisterResponse(registerationState: registerState);
  }

  @override
  Future<bool> forgotPassword(String email) async {
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

  @override
  Future<void> logout() async {
    debugPrint("--------------- Inside Logout ---------------");
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    debugPrint('Logged Out');
  }
}

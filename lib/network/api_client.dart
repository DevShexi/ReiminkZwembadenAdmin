import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/models/available_sensors.dart';
import 'package:reimink_zwembaden_admin/data/models/network/network_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ApiClient {
  Future<LoginResponse> login(AuthRequest loginRequest);
  Future<RegisterResponse> register(AuthRequest loginRequest);
  Future<bool> forgotPassword(String email);
  Future? logout();
  Future<void>? addNewSensor(Sensor newSensor);
  String? getUserEmail();
  String? getUserId();
  Future<String?> uploadSensorIconToStorage(File image);
  Future getAllSensors();
  Future<int> getAllSensorsCount();
  FirebaseAuth? firebaseAuth;
  FirebaseStorage? firebaseStorage;
  FirebaseFirestore? firebaseFirestore;
}

class ApiClientImpl implements ApiClient {
  @override
  FirebaseAuth? firebaseAuth = GetIt.I<FirebaseAuth>();
  @override
  FirebaseStorage? firebaseStorage = GetIt.I<FirebaseStorage>();
  @override
  FirebaseFirestore? firebaseFirestore = GetIt.I<FirebaseFirestore>();

  @override
  Future<LoginResponse> login(AuthRequest loginRequest) async {
    final String email = loginRequest.email.trim();
    final String password = loginRequest.password.trim();
    LoginState _loginState = LoginState.notLoggedIn;
    try {
      UserCredential userCredentials =
          await firebaseAuth!.signInWithEmailAndPassword(
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
      UserCredential userCredential = await firebaseAuth!
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
      await firebaseAuth!.sendPasswordResetEmail(email: email);
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
    await firebaseAuth!.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    debugPrint('Logged Out');
  }

  @override
  Future<void> addNewSensor(Sensor newSensor) async {
    final databaseInstance = FirebaseFirestore.instance;
    final response = await databaseInstance
        .collection("sensors")
        .doc(
          DateTime.now().toString(),
        )
        .set(
          newSensor.toJson(),
        )
        .then((value) => debugPrint("Sensor Added"))
        .catchError((error) => debugPrint("Failed to add sensor: $error"));
    return response;
  }

  @override
  String? getUserEmail() {
    final String? email = firebaseAuth!.currentUser?.email;
    return email;
  }

  @override
  String? getUserId() {
    final String? uid = firebaseAuth!.currentUser?.email;
    return uid;
  }

  @override
  Future<String?> uploadSensorIconToStorage(File image) async {
    String? downloadUrl;
    final storageRef = firebaseStorage!.ref();
    final iconRef = storageRef.child(
      DateTime.now().toString(),
    );
    try {
      await iconRef.putFile(image);
      downloadUrl = await iconRef.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
    return downloadUrl;
  }

  @override
  Future<List<Sensor?>> getAllSensors() async {
    final List<Sensor> sensors = [];
    await firebaseFirestore!.collection("sensors").get().then(
      (value) {
        for (var element in value.docs) {
          sensors.add(
            Sensor.fromJson(
              element.data(),
            ),
          );
        }
      },
    );
    return sensors;
  }

  @override
  Future<int> getAllSensorsCount() async {
    int count = 0;
    await firebaseFirestore!.collection("sensors").get().then(
      (value) {
        count = value.docs.length;
      },
    );
    return count;
  }
}

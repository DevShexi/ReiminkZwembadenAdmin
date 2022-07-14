import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/common/resources/collection_names.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ApiClient {
  Future<LoginResponse> login(AuthRequest loginRequest);
  Future<RegisterResponse> register(AuthRequest loginRequest);
  Future<bool> forgotPassword(String email);
  Future? logout();
  Future<void>? addNewSensor(Sensor newSensor);
  Future<void>? addClientPool(ClientPool clientPool);
  Future<void> deleteClientPool(String clientId, String poolId);
  Future<void> editClientPool(
      String clientId, String poolId, ClientPool updatedPool);
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientPoolsSnapshot(String id);
  Future<void>? updateSensor(String id, Sensor updatedSensor);
  Future<void>? deleteSensor(String id);
  Future<void>? addClientDatabaseConfig(String id, DatabaseConfig config);
  Future<DatabaseConfig?>? getClientDatabaseConfig(String id);
  String? getUserEmail();
  String? getUserId();
  Stream<QuerySnapshot<Map<String, dynamic>>> getSensorsSnapshot();
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientsSnapshot();
  Future approveClient({required String clientId});
  Future rejectClient({required String clientId});

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
    await firebaseAuth!.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    debugPrint('Logged Out');
  }

  @override
  Future<void> addNewSensor(Sensor newSensor) async {
    final response = await firebaseFirestore!
        .collection(CollectionNames.sensors)
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
  Future<void> addClientPool(ClientPool clientPool) async {
    final response = await firebaseFirestore!
        .collection(CollectionNames.clientPools)
        .doc(clientPool.clientId)
        .collection(CollectionNames.pools)
        .doc(clientPool.poolName)
        .set(
          clientPool.toJson(),
        )
        .then((value) => debugPrint("Client Pool Added"))
        .catchError((error) => debugPrint("Failed to add Client Pool: $error"));
    return response;
  }

  @override
  Future<void> editClientPool(
      String clientId, String poolId, ClientPool updatedPool) async {
    final response = await firebaseFirestore!
        .collection(CollectionNames.clientPools)
        .doc(clientId)
        .collection(CollectionNames.pools)
        .doc(poolId)
        .update(
          updatedPool.toJson(),
        )
        .then((value) => debugPrint("ClientPool Updated"))
        .catchError(
            (error) => debugPrint("Failed to update ClientPool: $error"));
    return response;
  }

  @override
  Future<void> deleteClientPool(String clientId, String poolId) async {
    final response = await firebaseFirestore!
        .collection(CollectionNames.clientPools)
        .doc(clientId)
        .collection(CollectionNames.pools)
        .doc(poolId)
        .delete()
        .then((value) => debugPrint("Pool Deleted Successfully"))
        .catchError((error) => debugPrint("Failed to delete Pool: $error"));
    return response;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientPoolsSnapshot(
      String id) {
    return firebaseFirestore!
        .collection(CollectionNames.clientPools)
        .doc(id)
        .collection(CollectionNames.pools)
        .snapshots();
  }

  @override
  Future<void>? addClientDatabaseConfig(
      String id, DatabaseConfig config) async {
    final response = await firebaseFirestore!
        .collection(CollectionNames.clientDatabaseConfig)
        .doc(id)
        .set(
          config.toJson(),
        )
        .then(
          (value) => debugPrint("Database Configuration Added for Client $id"),
        )
        .catchError((error) =>
            debugPrint("Failed to add Database Configuration: $error"));
    return response;
  }

  @override
  Future<DatabaseConfig?>? getClientDatabaseConfig(String id) async {
    DatabaseConfig? config;
    final response = await firebaseFirestore!
        .collection(CollectionNames.clientDatabaseConfig)
        .doc(id)
        .get();
    if (response.exists) {
      try {
        config =
            DatabaseConfig.fromJson(response.data() as Map<String, dynamic>);
      } catch (e) {
        debugPrint("Failed to get Database Configuration: $e");
      }
    }
    return config;
  }

  @override
  Future<void> updateSensor(String id, Sensor updatedSensor) async {
    final response = await firebaseFirestore!
        .collection(CollectionNames.sensors)
        .doc(id)
        .update(
          updatedSensor.toJson(),
        )
        .then((value) => debugPrint("Sensor Updated"))
        .catchError((error) => debugPrint("Failed to update sensor: $error"));
    return response;
  }

  @override
  Future<void> deleteSensor(String id) async {
    final response = await firebaseFirestore!
        .collection(CollectionNames.sensors)
        .doc(id)
        .delete()
        .then((value) => debugPrint("Sensor Deleted Successfully"))
        .catchError((error) => debugPrint("Failed to delete sensor: $error"));
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
  Stream<QuerySnapshot<Map<String, dynamic>>> getSensorsSnapshot() {
    return firebaseFirestore!.collection(CollectionNames.sensors).snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientsSnapshot() {
    return firebaseFirestore!.collection(CollectionNames.clients).snapshots();
  }

  @override
  Future approveClient({required String clientId}) async {
    await firebaseFirestore!
        .collection(CollectionNames.clients)
        .doc(clientId)
        .update(
      {"status": Strings.approvedStatus},
    );
  }

  @override
  Future rejectClient({required String clientId}) async {
    await firebaseFirestore!
        .collection(CollectionNames.clients)
        .doc(clientId)
        .update(
      {"status": Strings.rejectedStatus},
    );
  }
}

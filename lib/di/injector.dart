import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reimink_zwembaden_admin/data/dataSources/data_sources.dart';
import 'package:reimink_zwembaden_admin/data/dataSources/local_data_source.dart';
import 'package:reimink_zwembaden_admin/data/repositories/admin_repository.dart';
import 'package:reimink_zwembaden_admin/data/repositories/settings_repository.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._();
  static final _dependency = GetIt.instance;

  static void setUpLocator() {
    _setUpApiClient();
    _setUpAdminNetworkDataSource();
    _setUpSettingsNetworkDataSource();
    _setUpLocalDataSource();
    _setUpAdminRepository();
    _setUpSettingsRepository();
    _setUpFirebaseAuth();
    _setUpFirebaseStorage();
    _setUpFirebaseFirestore();
  }

  static void _setUpApiClient() {
    _dependency.registerFactory<ApiClient>(
      () => ApiClientImpl(),
    );
  }

  static void _setUpAdminNetworkDataSource() {
    _dependency.registerFactory<AdminNetworkDataSource>(
      () => AdminNetworkDataSourceImpl(),
    );
  }

  static void _setUpSettingsNetworkDataSource() {
    _dependency.registerFactory<SettingsNetworkDataSource>(
      () => SettingsNetworkDataSourceImpl(),
    );
  }

  static void _setUpLocalDataSource() {
    _dependency.registerFactory<LocalDataSource>(
      () => LocalDataSourceImpl(),
    );
  }

  static void _setUpAdminRepository() {
    _dependency.registerFactory<AdminRepository>(
      () => AdminRepositoryImpl(
        adminNetworkDataSource: _dependency(),
      ),
    );
  }

  static void _setUpSettingsRepository() {
    _dependency.registerFactory<SettingsRepository>(
      () => SettingsRepositoryImpl(
        settingsNetworkDataSource: _dependency(),
      ),
    );
  }

  static void _setUpFirebaseAuth() {
    _dependency.registerFactory<FirebaseAuth>(
      () => FirebaseAuth.instance,
    );
  }

  static void _setUpFirebaseStorage() {
    _dependency.registerFactory<FirebaseStorage>(
      () => FirebaseStorage.instance,
    );
  }

  static void _setUpFirebaseFirestore() {
    _dependency.registerFactory<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  }
}

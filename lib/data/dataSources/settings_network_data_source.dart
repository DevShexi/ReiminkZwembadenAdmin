import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/models/sensor.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';

abstract class SettingsNetworkDataSource {
  Future<void> addNewSensor(Sensor newSensor);
  Future<String?> uploadSensorIconToStorage(File image);
  Stream<QuerySnapshot<Map<String, dynamic>>> getSensorsSnapshot();
}

class SettingsNetworkDataSourceImpl implements SettingsNetworkDataSource {
  ApiClient apiClient;
  SettingsNetworkDataSourceImpl() : apiClient = GetIt.I<ApiClient>();
  @override
  Future<void> addNewSensor(Sensor newSensor) async {
    final response = apiClient.addNewSensor(newSensor);
    return response;
  }

  @override
  Future<String?> uploadSensorIconToStorage(File image) async {
    final downloadUrl = await apiClient.uploadSensorIconToStorage(image);
    return downloadUrl;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getSensorsSnapshot() {
    return apiClient.getSensorsSnapshot();
  }
}

import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/models/available_sensors.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';

abstract class SettingsNetworkDataSource {
  Future<void> addNewSensor(Sensor newSensor);
  Future<String?> uploadSensorIconToStorage(File image);
  Future<List<Sensor>> getAllSensors();
  Future<int> getAllSensorsCount();
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
  Future<List<Sensor>> getAllSensors() async {
    final sensors = await apiClient.getAllSensors();
    return sensors;
  }

  @override
  Future<int> getAllSensorsCount() async {
    return await apiClient.getAllSensorsCount();
  }
}
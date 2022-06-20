import 'dart:io';

import 'package:reimink_zwembaden_admin/data/dataSources/data_sources.dart';
import 'package:reimink_zwembaden_admin/data/models/available_sensors.dart';

abstract class SettingsRepository {
  Future<void> addNewSensor(Sensor newSensor);
  Future<String?> uploadSensorIconToStorage(File image);
  Future<List<Sensor>> getAllSensors();
  Future<int> getAllSensorsCount();
}

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required this.settingsNetworkDataSource,
  });
  final SettingsNetworkDataSource settingsNetworkDataSource;
  @override
  Future<void> addNewSensor(Sensor newSensor) async {
    final response = settingsNetworkDataSource.addNewSensor(newSensor);
    return response;
  }

  @override
  Future<String?> uploadSensorIconToStorage(File image) async {
    final downloadUrl =
        await settingsNetworkDataSource.uploadSensorIconToStorage(image);
    return downloadUrl;
  }

  @override
  Future<List<Sensor>> getAllSensors() async {
    final sensors = await settingsNetworkDataSource.getAllSensors();
    return sensors;
  }

  @override
  Future<int> getAllSensorsCount() async {
    return await settingsNetworkDataSource.getAllSensorsCount();
  }
}

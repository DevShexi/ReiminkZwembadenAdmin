import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reimink_zwembaden_admin/data/dataSources/data_sources.dart';
import 'package:reimink_zwembaden_admin/data/models/sensor.dart';

abstract class SettingsRepository {
  Future<void> addNewSensor(Sensor newSensor);
  Future<void> updateSensor(String id, Sensor updatedSensor);
  Future<void> deleteSensor(String id);
  Stream<QuerySnapshot> getSensorsSnapshot();
}

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required this.settingsNetworkDataSource,
  });
  final SettingsNetworkDataSource settingsNetworkDataSource;
  @override
  Future<void> addNewSensor(Sensor newSensor) async {
    final response = await settingsNetworkDataSource.addNewSensor(newSensor);
    return response;
  }

  @override
  Future<void> updateSensor(String id, Sensor updatedSensor) async {
    final response =
        await settingsNetworkDataSource.updateSensor(id, updatedSensor);
    return response;
  }

  @override
  Future<void> deleteSensor(String id) async {
    final response = await settingsNetworkDataSource.deleteSensor(id);
    return response;
  }

  @override
  Stream<QuerySnapshot> getSensorsSnapshot() {
    return settingsNetworkDataSource.getSensorsSnapshot();
  }
}

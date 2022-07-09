import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/models/sensor.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';

abstract class SettingsNetworkDataSource {
  Future<void> addNewSensor(Sensor newSensor);
  Future<void> updateSensor(String id, Sensor updatedSensor);
  Future<void> deleteSensor(String id);
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
  Future<void> updateSensor(String id, Sensor updatedSensor) async {
    final response = await apiClient.updateSensor(id, updatedSensor);
    return response;
  }

  @override
  Future<void> deleteSensor(String id) async {
    final response = await apiClient.deleteSensor(id);
    return response;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getSensorsSnapshot() {
    return apiClient.getSensorsSnapshot();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/models/client_pool.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';

abstract class ClientPoolsNetworkDataSource {
  Future addClientPool(ClientPool clientPool);
  Future<void> deleteClientPool(String clientId, String poolId);
  Future<void> editClientPool(ClientPool updatedPool);
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientPoolsSnapshot(String id);
}

class ClientPoolsNetworkDataSourceImpl implements ClientPoolsNetworkDataSource {
  final ApiClient _apiClient;
  ClientPoolsNetworkDataSourceImpl() : _apiClient = GetIt.I<ApiClient>();
  @override
  Future addClientPool(ClientPool clientPool) async {
    final response = await _apiClient.addClientPool(clientPool);
    return response;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientPoolsSnapshot(
      String id) {
    return _apiClient.getClientPoolsSnapshot(id);
  }

  @override
  Future<void> deleteClientPool(String clientId, String poolId) async {
    return await _apiClient.deleteClientPool(clientId, poolId);
  }

  @override
  Future<void> editClientPool(ClientPool updatedPool) async {
    return await _apiClient.editClientPool(updatedPool);
  }
}

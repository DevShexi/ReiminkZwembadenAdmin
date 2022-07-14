import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reimink_zwembaden_admin/data/dataSources/client_pools_network_data_source.dart';
import 'package:reimink_zwembaden_admin/data/models/client_pool.dart';

abstract class ClientPoolRepository {
  Future addClientPool(ClientPool clientPool);
  Future<void> deleteClientPool(String clientId, String poolId);
  Future<void> editClientPool(
      String clientId, String poolId, ClientPool updatedPool);
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientPoolsSnapshot(String id);
}

class ClientPoolRepositoryImpl implements ClientPoolRepository {
  final ClientPoolsNetworkDataSource clientPoolNetworkDataSource;
  ClientPoolRepositoryImpl({required this.clientPoolNetworkDataSource});

  @override
  Future addClientPool(ClientPool clientPool) async {
    final response =
        await clientPoolNetworkDataSource.addClientPool(clientPool);
    return response;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientPoolsSnapshot(
      String id) {
    return clientPoolNetworkDataSource.getClientPoolsSnapshot(id);
  }

  @override
  Future<void> deleteClientPool(String clientId, String poolId) async {
    return await clientPoolNetworkDataSource.deleteClientPool(clientId, poolId);
  }

  @override
  Future<void> editClientPool(
      String clientId, String poolId, ClientPool updatedPool) async {
    return await clientPoolNetworkDataSource.editClientPool(
        clientId, poolId, updatedPool);
  }
}

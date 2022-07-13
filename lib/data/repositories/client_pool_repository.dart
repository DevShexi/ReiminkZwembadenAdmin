import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reimink_zwembaden_admin/data/dataSources/client_pools_network_data_source.dart';
import 'package:reimink_zwembaden_admin/data/models/client_pool.dart';

abstract class ClientPoolRepository {
  Future addClientPool(ClientPool clientPool);
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
}

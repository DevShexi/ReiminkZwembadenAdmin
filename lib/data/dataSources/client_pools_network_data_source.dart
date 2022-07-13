import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/models/client_pool.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';

abstract class ClientPoolsNetworkDataSource {
  Future addClientPool(ClientPool clientPool);
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
}

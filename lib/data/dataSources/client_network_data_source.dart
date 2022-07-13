import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';

abstract class ClientsNetworkDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientsSnapshot();
  Future approveClient({required String clientId});
  Future rejectClient({required String clientId});
  Future<void>? addClientDatabaseConfig(String id, DatabaseConfig config);
  Future<DatabaseConfig?>? getClientDatabaseConfig(String id);
}

class ClientsNetworkDataSourceImpl implements ClientsNetworkDataSource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientsSnapshot() {
    return GetIt.I<ApiClient>().getClientsSnapshot();
  }

  @override
  Future approveClient({required String clientId}) async {
    return await GetIt.I<ApiClient>().approveClient(clientId: clientId);
  }

  @override
  Future rejectClient({required String clientId}) async {
    return await GetIt.I<ApiClient>().rejectClient(clientId: clientId);
  }

  @override
  Future<void>? addClientDatabaseConfig(
      String id, DatabaseConfig config) async {
    return await GetIt.I<ApiClient>().addClientDatabaseConfig(id, config);
  }

  @override
  Future<DatabaseConfig?>? getClientDatabaseConfig(String id) async {
    return await GetIt.I<ApiClient>().getClientDatabaseConfig(id);
  }
}

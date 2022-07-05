import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';

abstract class ClientsNetworkDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientsSnapshot();
  Future approveClient({required String clientId});
  Future rejectClient({required String clientId});
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
}

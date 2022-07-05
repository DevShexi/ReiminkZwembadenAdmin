import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reimink_zwembaden_admin/data/dataSources/client_network_data_source.dart';

abstract class ClientsRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientsSnapshot();
  Future<void> approveClient({required String clientId});

  Future<void> rejectClient({required String clientId});
}

class ClientsRepositoryImpl implements ClientsRepository {
  const ClientsRepositoryImpl({required this.clientsNetworkDataSource});
  final ClientsNetworkDataSource clientsNetworkDataSource;
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getClientsSnapshot() {
    return clientsNetworkDataSource.getClientsSnapshot();
  }

  @override
  Future approveClient({required String clientId}) async {
    return clientsNetworkDataSource.approveClient(clientId: clientId);
  }

  @override
  Future rejectClient({required String clientId}) {
    return clientsNetworkDataSource.rejectClient(clientId: clientId);
  }
}

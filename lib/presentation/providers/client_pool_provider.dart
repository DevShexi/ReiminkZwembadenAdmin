import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/models/client_pool.dart';
import 'package:reimink_zwembaden_admin/data/models/pool_sensor.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';

class AddClientPoolNotifier extends StateNotifier<ScreenState> {
  AddClientPoolNotifier({required this.apiClient})
      : super(ScreenState.initial());
  final ApiClient apiClient;

  void addClientPool({
    required String clientName,
    required String clientId,
    required String poolName,
    required String poolTopic,
    required List<PoolSensor> poolSensors,
  }) async {
    try {
      state = ScreenState.loading();
      final response = await apiClient.addClientPool(ClientPool(
        clientName: clientName,
        clientId: clientId,
        poolName: poolName,
        poolTopic: poolTopic,
        poolSensors: poolSensors,
      ));
      state = ScreenState.success("success");
    } on FirebaseException catch (e) {
      state = ScreenState.error(e.message);
    }
  }
}

final addClientPoolNotifierProvider =
    StateNotifierProvider<AddClientPoolNotifier, ScreenState>(
  (ref) => AddClientPoolNotifier(
    apiClient: GetIt.I<ApiClient>(),
  ),
);

final clientPoolsProvider = StreamProvider.family
    .autoDispose<QuerySnapshot<Map<String, dynamic>>, String>(
  (ref, id) {
    return GetIt.I<ApiClient>().getClientPoolsSnapshot(id);
  },
);

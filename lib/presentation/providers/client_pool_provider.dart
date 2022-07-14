import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/data/models/client_pool.dart';
import 'package:reimink_zwembaden_admin/data/models/pool_sensor.dart';
import 'package:reimink_zwembaden_admin/data/repositories/client_pool_repository.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';

class AddClientPoolNotifier extends StateNotifier<ScreenState> {
  AddClientPoolNotifier({required this.clientPoolRepository})
      : super(ScreenState.initial());
  final ClientPoolRepository clientPoolRepository;

  void addClientPool({
    required String clientName,
    required String clientId,
    required String poolName,
    required String poolTopic,
    required List<PoolSensor> poolSensors,
  }) async {
    try {
      state = ScreenState.loading();
      await clientPoolRepository.addClientPool(ClientPool(
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

final addClientPoolNotifierProviderr =
    StateNotifierProvider<AddClientPoolNotifier, ScreenState>(
  (ref) => AddClientPoolNotifier(
    clientPoolRepository: GetIt.I<ClientPoolRepository>(),
  ),
);

final clientPoolsProvider = StreamProvider.family
    .autoDispose<QuerySnapshot<Map<String, dynamic>>, String>(
  (ref, id) {
    return GetIt.I<ApiClient>().getClientPoolsSnapshot(id);
  },
);

class ClientPoolNotifier extends StateNotifier<ScreenState> {
  ClientPoolNotifier({required this.clientPoolRepository})
      : super(ScreenState.initial());
  final ClientPoolRepository clientPoolRepository;
  void addPool({
    required String clientName,
    required String clientId,
    required String poolName,
    required String poolTopic,
    required List<PoolSensor> poolSensors,
  }) async {
    state = ScreenState.loading();
    try {
      clientPoolRepository.addClientPool(ClientPool(
          clientName: clientName,
          clientId: clientId,
          poolName: poolName,
          poolTopic: poolTopic,
          poolSensors: poolSensors));
      state = ScreenState.success(Strings.poolDuplicatedSuccessMessage);
    } catch (e) {
      state = ScreenState.error(
          "${Strings.poolDuplicatedErrorMessage} : ${e.toString()}");
    }
  }

  void editPool({
    required String clientName,
    required String poolId,
    required String clientId,
    required String poolName,
    required String poolTopic,
    required List<PoolSensor> poolSensors,
  }) async {
    state = ScreenState.loading();
    try {
      clientPoolRepository.editClientPool(
        clientId,
        poolId,
        ClientPool(
            clientName: clientName,
            clientId: clientId,
            poolName: poolName,
            poolTopic: poolTopic,
            poolSensors: poolSensors),
      );
      state = ScreenState.success(Strings.poolEditSuccessMessage);
    } catch (e) {
      state = ScreenState.error(
          "${Strings.poolEditErrorMessage} : ${e.toString()}");
    }
  }

  void deletePool({required String clientId, required String poolId}) async {
    state = ScreenState.loading();
    try {
      await clientPoolRepository.deleteClientPool(clientId, poolId);
      state = ScreenState.success(Strings.poolDeletedSuccessMessage);
    } catch (e) {
      state = ScreenState.error(
          "${Strings.poolDeletedErrorMessage} : ${e.toString()}");
    }
  }
}

final clientPoolNotifierProvider =
    StateNotifierProvider<ClientPoolNotifier, ScreenState>(
  (ref) => ClientPoolNotifier(
    clientPoolRepository: GetIt.I<ClientPoolRepository>(),
  ),
);

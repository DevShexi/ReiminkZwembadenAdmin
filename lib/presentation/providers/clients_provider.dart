import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/data/models/network/clients.dart';
import 'package:reimink_zwembaden_admin/data/repositories/clients_repository.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';

final clientsSnapshotProvider = StreamProvider.autoDispose(
  (ref) {
    return GetIt.I<ClientsRepository>().getClientsSnapshot();
  },
);

final clientsNotifierProvider =
    StateNotifierProvider.autoDispose<ClientsNotifier, ScreenState>(
  ((ref) => ClientsNotifier(clientsRepository: GetIt.I<ClientsRepository>())),
);

class ClientsNotifier extends StateNotifier<ScreenState> {
  ClientsNotifier({required this.clientsRepository})
      : super(ScreenState.initial());
  final ClientsRepository clientsRepository;

  // void getClients({required String status}) {
  //   try {
  //     state = ScreenState.loading();
  //     final clientsSnapshot = clientsRepository.getClientsSnapshot();
  //     clientsSnapshot.forEach((element) {
  //       final List<Client> clients = [];
  //       for (var client in element.docs) {
  //         if (client["status"] == status) {
  //           clients.add(
  //             Client.fromJson(client.data()),
  //           );
  //         }
  //       }
  //       state = ScreenState.success(clients);
  //     });
  //   } on FirebaseException catch (e) {
  //     state = ScreenState.error(e.message);
  //   }
  // }

  Future<void> approveClient({required String clientId}) async {
    try {
      state = ScreenState.loading();
      await clientsRepository.approveClient(clientId: clientId);
      state = ScreenState.success(0);
    } on FirebaseException catch (e) {
      state = ScreenState.error(e.message);
    }
  }

  Future<void> rejectClient({required String clientId}) async {
    try {
      state = ScreenState.loading();
      await clientsRepository.rejectClient(clientId: clientId);
      state = ScreenState.success(0);
    } on FirebaseException catch (e) {
      state = ScreenState.error(e.message);
    }
  }
}

Clients? clients;
final clientsProvider = FutureProvider.autoDispose
    .family<List<Client>, String>((ref, clientType) async {
  final content = json.decode(
    await rootBundle.loadString('assets/json/clients.json'),
  ) as Map<String, Object?>;
  final List<Client> response = [];
  final clients = Clients.fromJson(content);
  switch (clientType) {
    case Strings.rejectedClientType:
      response.addAll(clients.rejectedClients);
      break;
    case Strings.requestClientType:
      response.addAll(clients.requests);
      break;
    default:
      response.addAll(clients.approvedClients);
  }
  await Future.delayed(const Duration(milliseconds: 500));
  return response;
});

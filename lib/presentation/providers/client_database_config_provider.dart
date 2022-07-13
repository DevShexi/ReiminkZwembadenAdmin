import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/data/repositories/clients_repository.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/screen_state.dart';

class AddClientDatabaseConfigNotifier extends StateNotifier<ScreenState> {
  AddClientDatabaseConfigNotifier({required this.clientsRepository})
      : super(ScreenState.initial());
  final ClientsRepository clientsRepository;

  Future<void> addClientDatabaseConfig({
    required String id,
    required String hostName,
    required String port,
    required String userName,
    required String databaseName,
    required String password,
  }) async {
    state = ScreenState.loading();
    try {
      DatabaseConfig config = DatabaseConfig(
          hostName: hostName,
          port: port,
          userName: userName,
          databaseName: databaseName,
          password: password);
      await clientsRepository.addClientDatabaseConfig(id, config);
      state = ScreenState.success("success");
    } catch (e) {
      state = ScreenState.error(e.toString());
    }
  }
}

final addClientDatabaseConfigNotifierProvider =
    StateNotifierProvider<AddClientDatabaseConfigNotifier, ScreenState>(
  (ref) => AddClientDatabaseConfigNotifier(
    clientsRepository: GetIt.I<ClientsRepository>(),
  ),
);

final clientDatabaseConfigProvider =
    FutureProvider.family.autoDispose<DatabaseConfig?, String>(
  (ref, id) {
    return GetIt.I<ClientsRepository>().getClientDatabaseConfig(id);
  },
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/error/error_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/loader.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/requests/client_request_tile.dart';

class NewRequests extends ConsumerWidget {
  const NewRequests({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(clientsNotifierProvider, (_, ScreenState screenState) {
      if (screenState.stateType == StateType.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(screenState.data),
            backgroundColor: Colors.red,
            duration: const Duration(
              milliseconds: 800,
            ),
          ),
        );
      } else if (screenState.stateType == StateType.success) {
        ref.refresh((clientsSnapshotProvider));
      } else if (screenState.stateType == StateType.loading) {}
    });
    final requests = ref.watch(clientsSnapshotProvider);
    return requests.when(data: (data) {
      final List<Client> pendingClients = [];
      if (data.docs.isNotEmpty) {
        for (var client in data.docs) {
          if (client['status'] == Strings.pendingStatus) {
            pendingClients.add(Client.fromJson(client.data()));
          }
        }
      }
      return PendingClients(pendingClients: pendingClients);
    }, error: (err, trace) {
      return ErrorScreen(
        error: err.toString(),
        onRefresh: () {
          ref.refresh(
            clientsProvider(type),
          );
        },
      );
    }, loading: () {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) => const ClientRequestTileLoader(),
      );
    });
  }
}

class PendingClients extends StatelessWidget {
  const PendingClients({Key? key, required this.pendingClients})
      : super(key: key);
  final List<Client> pendingClients;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: pendingClients.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: pendingClients.length,
                  itemBuilder: (context, index) =>
                      ClientRequestTile(client: pendingClients[index]))
              : const Center(
                  child: Text(
                    Strings.noClients,
                  ),
                ),
        ),
        Consumer(
          builder: (context, ref, _) {
            var screenState = ref.watch(clientsNotifierProvider);
            if (screenState.stateType == StateType.loading) {
              return const Loader();
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

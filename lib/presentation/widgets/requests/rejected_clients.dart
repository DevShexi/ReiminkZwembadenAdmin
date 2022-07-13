import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/error/error_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/requests/rejected_client_display_tile.dart';

class RegectedClients extends ConsumerWidget {
  const RegectedClients({
    Key? key,
    required this.type,
  }) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(clientsSnapshotProvider);
    return requests.when(data: (data) {
      final List<Client> rejectedClients = [];
      if (data.docs.isNotEmpty) {
        for (var client in data.docs) {
          if (client['status'] == Strings.rejectedStatus) {
            rejectedClients.add(Client.fromJson(client.data()));
          }
        }
      }
      return rejectedClients.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: rejectedClients.length,
              itemBuilder: (context, index) => RejectedClientDisplayTile(
                client: rejectedClients[index],
              ),
            )
          : const Center(
              child: Text(
                Strings.noClients,
              ),
            );
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
        itemBuilder: (context, index) =>
            const RejectedClientDisplayTileLoader(),
      );
    });
  }
}

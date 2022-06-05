import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
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
    final requests = ref.watch(clientsProvider(type));
    return requests.when(data: (data) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) => RejectedClientDisplayTile(
          name: data[index].name,
          email: data[index].email,
          imageUrl: data[index].imageUrl ?? Strings.dummyImage,
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/data/models/pools_listing_screen_args.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/error/error_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/clients/client_display_tile.dart';

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(clientsProvider(
      Strings.approvedClientType,
    ));
    return requests.when(data: (data) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                PagePath.poolsListingScreen,
                arguments: PoolsListingScreenArgs(
                  clientName: data[index].name,
                  clientUid: data[index].id,
                ),
              );
            },
            child: ClientDisplayTile(
              name: data[index].name,
              email: data[index].email,
              imageUrl: data[index].imageUrl ?? Strings.dummyImage,
            ),
          ),
        ),
      );
    }, error: (err, trace) {
      return ErrorScreen(
        error: err.toString(),
        onRefresh: () {
          ref.refresh(
            clientsProvider(
              Strings.approvedClientType,
            ),
          );
        },
      );
    }, loading: () {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) => const ClientDisplayTileLoader(),
        ),
      );
    });
  }
}
// Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16.0,
//       ),
//       child: Column(
//         children: <Widget>[
//           isLoading
//               ? ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: 3,
//                   itemBuilder: (context, index) =>
//                       const ClientDisplayTileLoader(),
//                 )
//               : ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: 3,
//                   itemBuilder: (context, index) => const ClientDisplayTile(
//                     name: "Lucy Freeman",
//                     email: "freeman_lucy@example.com",
//                     imageUrl: Strings.dummyImage,
//                   ),
//                 ),
//         ],
//       ),
//     );
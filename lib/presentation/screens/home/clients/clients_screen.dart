import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/network/network_models.dart';
import 'package:reimink_zwembaden_admin/data/models/pools_listing_screen_args.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/error/error_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/clients/client_display_tile.dart';

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  List<Client> getApprovedClients(QuerySnapshot<Map<String, dynamic>> data) {
    final List<Client> clients = [];
    for (var element in data.docs) {
      if (element["status"] == "approved") {
        clients.add(Client.fromJson(element.data()));
      }
    }
    return clients;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(clientsSnapshotProvider);
    return requests.when(
      loading: () {
        return const LoadingClientsListShimmer();
      },
      data: (data) {
        return AprovedClientsList(data: getApprovedClients(data));
      },
      error: (err, trace) {
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
      },
    );
  }
}

class AprovedClientsList extends StatelessWidget {
  const AprovedClientsList({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<Client> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.lightGrey,
        title: const Text(
          Strings.clients,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: data.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PagePath.poolsListing,
                      arguments: PoolsListingScreenArgs(
                        clientName: data[index].clientName,
                        clientUid: data[index].clientId,
                      ),
                    );
                  },
                  child: ClientDisplayTile(
                    client: data[index],
                  ),
                ),
              )
            : const Center(
                child: Text(Strings.noClients),
              ),
      ),
    );
  }
}

class LoadingClientsListShimmer extends StatelessWidget {
  const LoadingClientsListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.lightGrey,
        title: const Text(Strings.clients),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) => const ClientDisplayTileLoader(),
        ),
      ),
    );
  }
}

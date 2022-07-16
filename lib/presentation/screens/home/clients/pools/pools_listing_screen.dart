import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/client_pool.dart';
import 'package:reimink_zwembaden_admin/data/models/pools_listing_screen_args.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/client_database_config_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/client_pool_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/clients/pools/client_pool_extension_tile.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/clients/pools/clients_database_configurations.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_elevated_button.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/loader.dart';

class PoolsListingScreen extends ConsumerWidget {
  const PoolsListingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(clientPoolNotifierProvider, (_, ScreenState screenState) {
      if (screenState.stateType == StateType.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(Strings.sensorAddedSuccessMessage),
            backgroundColor: Colors.green,
            duration: Duration(
              milliseconds: 800,
            ),
          ),
        );
      }
      if (screenState.stateType == StateType.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(screenState.errorMessage ?? screenState.data),
            backgroundColor: Colors.red,
            duration: const Duration(
              milliseconds: 800,
            ),
          ),
        );
      }
    });
    final args =
        ModalRoute.of(context)!.settings.arguments as PoolsListingScreenArgs;
    final clientPoolsSnapshot = ref.watch(clientPoolsProvider(args.clientUid));
    final config = ref.watch(clientDatabaseConfigProvider(args.clientUid));
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.backgroundGrey,
          appBar: AppBar(
            title: Text(
              args.clientName,
            ),
            centerTitle: true,
            actions: [
              Center(
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  elevation: 3.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PagePath.addPool,
                        arguments: args,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  config.when(
                    data: (data) {
                      if (data == null) {
                        return Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 40),
                              child: Text(
                                Strings.noConfigurationsFound,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: CustomElevatedButton(
                                label: Strings.configure,
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    PagePath.addDatabaseConfig,
                                    arguments: args.clientUid,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return ClientDatabaseConfigurations(
                        config: data,
                      );
                    },
                    error: (err, stack) {
                      return const SizedBox.shrink();
                    },
                    loading: () {
                      return const ClientDatabaseConfigurationsLoader();
                    },
                  ),
                  const SizedBox(height: 4.0),
                  const Divider(thickness: 1.0, color: AppColors.textGrey),
                  const SizedBox(height: 4.0),
                  clientPoolsSnapshot.when(
                    data: (data) {
                      List<ClientPool> clientPools = [];
                      for (var pool in data.docs) {
                        clientPools.add(ClientPool.fromJson(pool.data()));
                      }
                      return ClientPoolsBuilder(clientPools: clientPools);
                    },
                    error: (error, stack) => const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final screenState = ref.watch(clientPoolNotifierProvider);
            if (screenState.stateType == StateType.loading) {
              return const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Loader(),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}

class ClientPoolsBuilder extends StatelessWidget {
  const ClientPoolsBuilder({Key? key, required this.clientPools})
      : super(key: key);
  final List<ClientPool> clientPools;

  @override
  Widget build(BuildContext context) {
    return clientPools.isNotEmpty
        ? SingleChildScrollView(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: clientPools.length,
              itemBuilder: ((context, index) {
                return PoolExpansionTile(
                  clientPool: clientPools[index],
                  poolId: clientPools[index].poolId,
                );
              }),
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              Strings.tapPlusToAddPoolMessage,
              textAlign: TextAlign.center,
            ),
          );
  }
}

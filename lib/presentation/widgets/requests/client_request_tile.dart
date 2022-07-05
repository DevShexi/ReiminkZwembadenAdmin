import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/network/clients.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_elevated_button.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_loading_indicator.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_outlined_button.dart';

class ClientRequestTile extends ConsumerWidget {
  const ClientRequestTile({
    Key? key,
    required this.client,
  }) : super(key: key);
  final Client client;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 29.0,
                backgroundColor: AppColors.pink,
                backgroundImage: client.imageUrl != null
                    ? NetworkImage(client.imageUrl!)
                    : null,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.clientName,
                      style: AppStyles.title2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      client.clientEmail,
                      style: AppStyles.subtitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  label: Strings.decline,
                  onPressed: () {
                    ref
                        .read(clientsNotifierProvider.notifier)
                        .rejectClient(clientId: client.clientId);
                  },
                ),
              ),
              const SizedBox(
                width: 30.0,
              ),
              Expanded(
                child: CustomElevatedButton(
                  label: Strings.accept,
                  onPressed: () {
                    ref
                        .read(clientsNotifierProvider.notifier)
                        .approveClient(clientId: client.clientId);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ClientRequestTileLoader extends StatelessWidget {
  const ClientRequestTileLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: 0.4,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const CustomLoadingIndicator(
                  width: 58,
                  height: 58,
                  radius: 58,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLoadingIndicator(width: width * 0.4, height: 26.0),
                      const SizedBox(height: 5.0),
                      CustomLoadingIndicator(width: width * 0.55, height: 18.0),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: const <Widget>[
                Expanded(
                  child: CustomLoadingIndicator(
                    height: 36,
                    width: 1,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Expanded(
                  child: CustomLoadingIndicator(
                    height: 36,
                    width: 1,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

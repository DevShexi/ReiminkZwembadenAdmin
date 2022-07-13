import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_loading_indicator.dart';

class ClientDatabaseConfigurations extends StatelessWidget {
  const ClientDatabaseConfigurations({Key? key, required this.config})
      : super(key: key);
  final DatabaseConfig config;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.clientDatabaseConfig,
            style: AppStyles.title2,
          ),
          const Divider(
            thickness: 1.0,
            color: AppColors.lightBlue,
          ),
          Row(
            children: [
              InfoCard(label: Strings.hostName, value: config.hostName),
              InfoCard(label: Strings.port, value: config.port),
            ],
          ),
          Row(
            children: [
              InfoCard(label: Strings.userName, value: config.userName),
              InfoCard(label: Strings.databaseName, value: config.databaseName),
            ],
          ),
          Row(
            children: [
              InfoCard(label: Strings.password, value: config.password),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class ClientDatabaseConfigurationsLoader extends StatelessWidget {
  const ClientDatabaseConfigurationsLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomLoadingIndicator(width: 200, height: 22),
            const Divider(
              thickness: 1.0,
              color: AppColors.lightBlue,
            ),
            Row(
              children: const [InfoCardLoader(), InfoCardLoader()],
            ),
            Row(
              children: const [InfoCardLoader(), InfoCardLoader()],
            ),
            Row(
              children: const [InfoCardLoader(), InfoCardLoader()],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppStyles.smallLabelPrimary),
              Text(
                value,
                style: AppStyles.smallLabel2.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCardLoader extends StatelessWidget {
  const InfoCardLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomLoadingIndicator(width: 100, height: 18),
              SizedBox(height: 4),
              CustomLoadingIndicator(width: 75, height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

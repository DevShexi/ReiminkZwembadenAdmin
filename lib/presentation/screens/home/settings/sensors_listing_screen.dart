import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/data/models/available_sensors.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/settings_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/error/error_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/settings/sensor_listing_tile.dart';

class SensorsListingScreen extends ConsumerWidget {
  const SensorsListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensors = ref.watch(sensorsProvider);
    return sensors.when(
      data: (data) => SensorsList(sensors: data),
      error: (error, stack) => ErrorScreen(
        error: error.toString(),
        onRefresh: () {
          ref.refresh(sensorsProvider);
        },
      ),
      loading: () => const SensorsListLoader(),
    );
  }
}

class SensorsList extends StatelessWidget {
  const SensorsList({Key? key, required this.sensors}) : super(key: key);
  final List<Sensor> sensors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: const Text(
          Strings.sensors,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: sensors.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: sensors.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: SensorListingTile(
                    sensor: sensors[index],
                  ),
                ),
              )
            : const SizedBox(
                height: double.infinity,
                child: Center(
                  child: Text("Currently There are no sensors"),
                ),
              ),
      ),
    );
  }
}

class SensorsListLoader extends StatelessWidget {
  const SensorsListLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: const Text(
          Strings.sensors,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: SensorListingTileLoader(),
            ),
          ),
        ),
      ),
    );
  }
}

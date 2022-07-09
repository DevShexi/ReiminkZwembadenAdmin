import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/sensor.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/settings_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/error/error_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/settings/sensor_listing_tile.dart';

class SensorsListingScreen extends ConsumerWidget {
  const SensorsListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensors = ref.watch(sensorsSnapshotProvider);
    return sensors.when(
      data: (data) => SensorsList(
        sensorsSnapshot: data,
        // sensors: data.docs.map((e) {
        //   final json = e.data() as Map<String, dynamic>;
        //   return Sensor.fromJson(json);
        // }).toList(),
      ),
      error: (error, stack) => ErrorScreen(
        error: error.toString(),
        onRefresh: () {
          ref.refresh(sensorsSnapshotProvider);
        },
      ),
      loading: () => const SensorsListLoader(),
    );
  }
}

class SensorsList extends StatelessWidget {
  const SensorsList({Key? key, required this.sensorsSnapshot})
      : super(key: key);
  final QuerySnapshot sensorsSnapshot;

  void onAdd(BuildContext context) {
    Navigator.pushNamed(context, PagePath.addSensor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: const Text(
          Strings.sensors,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              onAdd(context);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: sensorsSnapshot.docs.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: sensorsSnapshot.docs.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: SensorListingTile(
                    id: sensorsSnapshot.docs[index].id,
                    sensor: Sensor.fromJson(sensorsSnapshot.docs[index].data()
                        as Map<String, dynamic>),
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

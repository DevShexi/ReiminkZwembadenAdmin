import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/client_pool_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/pool_sensor_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/error/error_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/clients/pools/add_sensor_tile.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/loader.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class AddPoolSensorsScreen extends ConsumerWidget {
  const AddPoolSensorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(addClientPoolNotifierProvider, (_, ScreenState screenState) {
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
        ref.refresh(sensorsSnapshotProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(Strings.sensorAddedSuccessMessage),
            backgroundColor: Colors.green,
            duration: Duration(
              milliseconds: 800,
            ),
          ),
        );
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.backgroundGrey,
          appBar: AppBar(
            title: const Text(
              Strings.addPoolSensor,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer(
              builder: ((context, ref, child) {
                final sensors = ref.watch(sensorsSnapshotProvider);
                return sensors.when(
                  data: (snapshot) {
                    final poolSensors = snapshot.docs.map(
                      (e) {
                        final json = e.data() as Map<String, dynamic>;
                        return Sensor.fromJson(json).toPoolSensor();
                      },
                    ).toList();

                    return SensorListBuilder(sensors: poolSensors);
                  },
                  error: (err, _) {
                    return ErrorScreen(
                      error: err.toString(),
                      onRefresh: () {
                        ref.refresh(sensorsSnapshotProvider);
                      },
                    );
                  },
                  loading: () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                        const AddSensorTileLoader(),
                  ),
                );
              }),
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            var screenState = ref.watch(addClientPoolNotifierProvider);
            if (screenState.stateType == StateType.loading) {
              return const Loader();
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}

class SensorListBuilder extends ConsumerStatefulWidget {
  const SensorListBuilder({Key? key, required this.sensors}) : super(key: key);
  final List<PoolSensor> sensors;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SensorListBuilderState();
}

class _SensorListBuilderState extends ConsumerState<SensorListBuilder> {
  void increaseCounter(int index) {
    widget.sensors[index].count < widget.sensors[index].maxSensorCount!
        ? widget.sensors[index].count++
        : widget.sensors[index].maxSensorCount!;
    setState(() {});
  }

  void decreaseCounter(int index) {
    widget.sensors[index].count > 1 ? widget.sensors[index].count-- : 1;
    setState(() {});
  }

  void toggleSelect(int index) {
    if (widget.sensors[index].isSelected != true) {
      setState(() {
        widget.sensors[index].isSelected = true;
        widget.sensors[index].count = 1;
      });
    } else {
      setState(() {
        widget.sensors[index].isSelected = false;
        widget.sensors[index].count = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.sensors.length,
            itemBuilder: (context, index) => AddSensorTile(
              sensor: widget.sensors[index],
              isChecked: widget.sensors[index].isSelected!,
              value: widget.sensors[index].count,
              increaseCount: () {
                increaseCounter(index);
              },
              decreaseCount: () {
                decreaseCounter(index);
              },
              toggleChecked: () {
                toggleSelect(index);
              },
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) => PrimaryButton(
            label: "Save",
            onPressed: () {
              final clientName = ref.read(clientNameProvider.state).state!;
              final clientID = ref.read(clientIdProvider.state).state!;
              final poolName = ref.read(poolNameProvider.state).state!;
              final poolTopic = ref.read(poolTopicProvider.state).state!;
              final poolSensors = widget.sensors;
              ref.watch(addClientPoolNotifierProvider.notifier).addClientPool(
                    clientName: clientName,
                    clientId: clientID,
                    poolName: poolName,
                    poolTopic: poolTopic,
                    poolSensors: poolSensors,
                  );
              // print(
              //   ClientPool(
              //           clientName: clientName,
              //           clientID: clientID,
              //           poolName: poolName,
              //           poolTopic: poolTopic,
              //           poolSensors: poolSensors)
              //       .toJson(),
              // );
              // print(ref.read(poolNameProvider.state).state);
              // print(ref.read(clientNameProvider.state).state);
              // print(ref.read(poolTopicProvider.state).state);
              // print(ref.read(clientIdProvider.state).state);
              // widget.sensors.forEach((element) {
              //   print(element.isSelected);
              //   print(element.count);
              // });
            },
          ),
        ),
      ],
    );
  }
}

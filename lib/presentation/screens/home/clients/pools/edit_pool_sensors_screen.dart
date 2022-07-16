import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/client_pool_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/clients/pools/add_sensor_tile.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/loader.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class EditPoolSensorsScreen extends ConsumerWidget {
  const EditPoolSensorsScreen({Key? key, required this.clientPool})
      : super(key: key);
  final ClientPool clientPool;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(clientPoolNotifierProvider, (_, ScreenState screenState) {
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
            child: SensorListBuilder(clientPool: clientPool),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            var screenState = ref.watch(clientPoolNotifierProvider);
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
  const SensorListBuilder({Key? key, required this.clientPool})
      : super(key: key);
  final ClientPool clientPool;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SensorListBuilderState();
}

class _SensorListBuilderState extends ConsumerState<SensorListBuilder> {
  List<PoolSensor> sensors = [];
  @override
  void initState() {
    sensors = widget.clientPool.poolSensors;
    super.initState();
  }

  void increaseCounter(int index) {
    sensors[index].count < sensors[index].maxSensorCount!
        ? sensors[index].count++
        : sensors[index].maxSensorCount!;
    setState(() {});
  }

  void decreaseCounter(int index) {
    sensors[index].count > 1 ? sensors[index].count-- : 1;
    setState(() {});
  }

  void toggleSelect(int index) {
    if (sensors[index].isSelected != true) {
      setState(() {
        sensors[index].isSelected = true;
        sensors[index].count = 1;
      });
    } else {
      setState(() {
        sensors[index].isSelected = false;
        sensors[index].count = 0;
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
            itemCount: sensors.length,
            itemBuilder: (context, index) => AddSensorTile(
              sensor: sensors[index],
              isChecked: sensors[index].isSelected!,
              value: sensors[index].count,
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
              ref.watch(clientPoolNotifierProvider.notifier).editPool(
                    poolName: widget.clientPool.poolName,
                    poolTopic: widget.clientPool.poolTopic!,
                    clientName: widget.clientPool.clientName,
                    poolId: widget.clientPool.poolId,
                    clientId: widget.clientPool.clientId,
                    poolSensors: sensors,
                  );
            },
          ),
        ),
      ],
    );
  }
}

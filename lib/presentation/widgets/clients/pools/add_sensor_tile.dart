import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/pool_sensor.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_counter.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_loading_indicator.dart';

class AddSensorTile extends StatelessWidget {
  const AddSensorTile({
    Key? key,
    required this.sensor,
    required this.isChecked,
    required this.value,
    required this.toggleChecked,
    required this.increaseCount,
    required this.decreaseCount,
  }) : super(key: key);
  final PoolSensor sensor;
  final bool isChecked;
  final int value;
  final Function() toggleChecked;
  final Function() increaseCount;
  final Function() decreaseCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        // vertical: 8.0,
        horizontal: 2.0,
      ).copyWith(
        right: 8.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        // horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Checkbox(
                value: sensor.isSelected,
                onChanged: (value) {
                  toggleChecked();
                },
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: sensor.iconUrl != null
                      ? Image.network(sensor.iconUrl!)
                      : const Icon(
                          Icons.info,
                          color: AppColors.primary,
                        ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: SizedBox(
                  child: Text(sensor.sensorName),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              AbsorbPointer(
                absorbing: !sensor.isSelected!,
                child: CustomCounter(
                  active: sensor.isSelected!,
                  value: sensor.count,
                  onDecrement: decreaseCount,
                  onIncrement: increaseCount,
                ),
              )
            ],
          ),
          sensor.count == sensor.maxSensorCount
              ? Text(
                  Strings.maxSelected,
                  style: AppStyles.extraSmallLabel.copyWith(
                    color: AppColors.error,
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class AddSensorTileLoader extends StatelessWidget {
  const AddSensorTileLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ).copyWith(
          right: 8.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          // horizontal: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CustomLoadingIndicator(width: 150, height: 24, radius: 4),
            CustomCounterLoader()
          ],
        ),
      ),
    );
  }
}

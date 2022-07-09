import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/settings/edit_sensor_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_alert_dialog.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_loading_indicator.dart';

class SensorListingTile extends ConsumerWidget {
  const SensorListingTile({
    Key? key,
    required this.id,
    required this.sensor,
  }) : super(key: key);
  final Sensor sensor;
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: AppColors.white,
      ),
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: sensor.iconUrl == null ? AppColors.lightBlue : null,
            ),
            child: sensor.iconUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      sensor.iconUrl!,
                      // fit: BoxFit.cover,
                    ),
                  )
                : const Center(
                    child: Icon(
                      Icons.question_mark,
                      color: AppColors.primary,
                    ),
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      sensor.sensorName,
                      style: AppStyles.title2,
                    ),
                    const Spacer(),
                    InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditSensorScreen(id: id, sensor: sensor),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            label: Strings.deleteSensor,
                            promptMessage: Strings.deleteSensorPromptMessage,
                            actionLabel: Strings.deleteBtnText,
                            action: () {
                              ref
                                  .watch(sensorNotifierProvider.notifier)
                                  .deleteSensor(id);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text(Strings.sensorDeletedSuccessMessage),
                                  backgroundColor: Colors.green,
                                  duration: Duration(
                                    milliseconds: 800,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.delete,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Strings.topic}: ${sensor.mqttTopic}",
                        style: AppStyles.subtitle,
                      ),
                      Text(
                        "${Strings.maximumCount}: ${sensor.maxSensorCount}",
                        style: AppStyles.subtitle,
                      ),
                    ],
                  ),
                ),
                if (sensor.minSet != null && sensor.maxSet != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${Strings.minSet}: ${sensor.minSet}",
                          style: AppStyles.subtitle,
                        ),
                        Text(
                          "${Strings.maxSet}: ${sensor.maxSet}",
                          style: AppStyles.subtitle,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SensorListingTileLoader extends StatefulWidget {
  const SensorListingTileLoader({Key? key}) : super(key: key);

  @override
  State<SensorListingTileLoader> createState() =>
      _SensorListingTileLoaderState();
}

class _SensorListingTileLoaderState extends State<SensorListingTileLoader> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: CustomLoadingIndicator(
                width: 35,
                height: 35,
                child: Center(
                  child: Icon(
                    Icons.question_mark,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CustomLoadingIndicator(
                        width: 150,
                        height: 20,
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(width: 4),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.delete,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CustomLoadingIndicator(
                        width: 130,
                        height: 12,
                      ),
                      CustomLoadingIndicator(
                        width: 100,
                        height: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

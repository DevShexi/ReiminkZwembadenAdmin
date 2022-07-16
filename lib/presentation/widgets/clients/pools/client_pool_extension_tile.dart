import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/client_pool_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/clients/pools/edit_pool_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/clients/pools/duplicate_pool_input_dialog.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_alert_dialog.dart';

class PoolExpansionTile extends ConsumerStatefulWidget {
  const PoolExpansionTile(
      {Key? key, required this.clientPool, required this.poolId})
      : super(key: key);
  final ClientPool clientPool;
  final String poolId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PoolExpansionTileState();
}

class _PoolExpansionTileState extends ConsumerState<PoolExpansionTile> {
  bool _customTileExpanded = false;
  List<PoolSensor> sensors = [];
  final GlobalKey _key = GlobalKey();

  Widget deleteDialog(
      {required WidgetRef ref,
      required String clientId,
      required String poolId}) {
    return CustomAlertDialog(
        label: "Delete Pool",
        promptMessage:
            "This pool and all its data will be deleted. Do you want to continue?",
        actionLabel: "Yes",
        action: () {
          ref
              .watch(clientPoolNotifierProvider.notifier)
              .deletePool(clientId: clientId, poolId: poolId);
          setState(() {
            _customTileExpanded = false;
          });
          Navigator.pop(context);
        });
  }

  @override
  void initState() {
    for (var sensor in widget.clientPool.poolSensors) {
      if (sensor.isSelected == true) {
        sensors.add(sensor);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          7.0,
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: _customTileExpanded,
            key: _key,
            backgroundColor: AppColors.white,
            collapsedBackgroundColor: AppColors.white,
            textColor: AppColors.primary,
            collapsedTextColor: AppColors.black,
            title: Text(
              widget.clientPool.poolName,
            ),
            // subtitle: const Text('Custom expansion arrow icon'),
            trailing: Icon(
              _customTileExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            children: <Widget>[
              const CustomDivider(),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PoolActionIconButton(
                      label: Strings.duplicate,
                      icon: Icons.copy,
                      action: () {
                        showDialog(
                          context: context,
                          builder: (builder) => DuplicatePoolInputDialog(
                              clientPool: widget.clientPool),
                        );
                      },
                    ),
                    PoolActionIconButton(
                      label: Strings.edit,
                      icon: Icons.edit,
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPoolScreen(
                              clientPool: widget.clientPool,
                            ),
                          ),
                        );
                      },
                    ),
                    PoolActionIconButton(
                      label: Strings.delete,
                      icon: Icons.delete,
                      color: AppColors.error,
                      action: () {
                        showDialog(
                          context: context,
                          builder: (context) => deleteDialog(
                              ref: ref,
                              clientId: widget.clientPool.clientId,
                              poolId: widget.clientPool.poolId),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: sensors.length,
                itemBuilder: ((context, index) {
                  return SensorSwitchTile(sensor: sensors[index]);
                }),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
          ),
        ),
      ),
    );
  }
}

class SensorSwitchTile extends StatefulWidget {
  const SensorSwitchTile({
    Key? key,
    required this.sensor,
  }) : super(key: key);
  final PoolSensor sensor;

  @override
  State<SensorSwitchTile> createState() => _SensorSwitchTileState();
}

class _SensorSwitchTileState extends State<SensorSwitchTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: AppColors.grey,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          widget.sensor.iconUrl != null
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.network(
                    widget.sensor.iconUrl!,
                  ),
                )
              : const Icon(
                  Icons.info_rounded,
                  color: AppColors.primary,
                  size: 24.0,
                ),
          const SizedBox(width: 10.0),
          Text(
            widget.sensor.sensorName,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const Spacer(),
          // Switch(
          //   onChanged: (value) {
          //     setState(() {
          //       _isOn != !_isOn!;
          //     });
          //   },
          //   value: _isOn!,
          //   activeColor: AppColors.blue,
          //   activeTrackColor: AppColors.lightBlue,
          //   inactiveThumbColor: AppColors.error,
          //   inactiveTrackColor: AppColors.errorLight,
          // )
        ],
      ),
    );
  }
}

class PoolActionIconButton extends StatelessWidget {
  const PoolActionIconButton(
      {Key? key,
      required this.label,
      required this.icon,
      required this.action,
      this.color})
      : super(key: key);
  final IconData icon;
  final String label;
  final Color? color;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Material(
          borderRadius: BorderRadius.circular(7.0),
          elevation: 3.0,
          child: InkWell(
            onTap: action,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                border: Border.all(
                  color: color ?? AppColors.blue,
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      color: color ?? AppColors.primary,
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: AppColors.white,
                        size: 16.0,
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          label,
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    fontSize: 12.0,
                                  ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10.0,
      ),
      height: 1,
      decoration: BoxDecoration(
          color: AppColors.textGrey.withOpacity(0.2),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 2.0),
              blurRadius: 5.0,
            ),
          ]),
    );
  }
}

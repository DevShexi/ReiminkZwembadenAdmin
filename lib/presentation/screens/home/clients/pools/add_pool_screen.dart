import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/common/resources/styles.dart';
import 'package:reimink_zwembaden_admin/data/models/pools_listing_screen_args.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/available_sensors_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/error/error_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_counter.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class AddPoolScreen extends StatefulWidget {
  const AddPoolScreen({Key? key}) : super(key: key);

  @override
  State<AddPoolScreen> createState() => _AddPoolScreenState();
}

class _AddPoolScreenState extends State<AddPoolScreen> {
  final TextEditingController _poolNameController = TextEditingController();
  final TextEditingController _poolTopicController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PoolsListingScreenArgs;
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          args.clientName,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10.0),
              CustomInputField(
                focusNode: _focusNode,
                controller: _poolNameController,
                label: Strings.poolName,
                isObscure: false,
                icon: Icons.pool,
              ),
              const SizedBox(height: 4.0),
              CustomInputField(
                controller: _poolTopicController,
                label: Strings.poolTopic,
                isObscure: false,
                icon: Icons.pool,
              ),
              const SizedBox(height: 4.0),
              Expanded(
                child: Consumer(
                  builder: ((context, ref, child) {
                    final sensors = ref.watch(sensorsSnapshotProvider);
                    return sensors.when(
                      data: (snapshot) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.docs.length,
                          itemBuilder: (context, index) => AddSensorTile(
                            name: snapshot.docs[index]["sensor_name"],
                            iconUrl: snapshot.docs[index]["icon_url"],
                            maxSensorCount: snapshot.docs[index]
                                ["max_sensor_count"],
                          ),
                        );
                      },
                      error: (err, _) {
                        return ErrorScreen(
                          error: err.toString(),
                          onRefresh: () {
                            ref.refresh(availableSensorsProvider);
                          },
                        );
                      },
                      loading: () => const CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }),
                ),
              ),
              // const Spacer(),
              const SizedBox(
                height: 10.0,
              ),
              PrimaryButton(
                label: "Save",
                onPressed: () {},
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddSensorTile extends StatefulWidget {
  const AddSensorTile({
    Key? key,
    required this.name,
    required this.maxSensorCount,
    this.iconUrl,
  }) : super(key: key);
  final String name;
  final String? iconUrl;
  final int maxSensorCount;

  @override
  State<AddSensorTile> createState() => _AddSensorTileState();
}

class _AddSensorTileState extends State<AddSensorTile> {
  final TextEditingController _sensorCounterController =
      TextEditingController();
  bool _isChecked = false;

  @override
  void dispose() {
    _sensorCounterController.dispose();
    super.dispose();
  }

  void toggleChecked(bool value) {
    setState(() {
      value
          ? _sensorCounterController.text = "1"
          : _sensorCounterController.clear();
      _isChecked = value;
    });
  }

  void limitQuantity(String value) {
    if (value.trim().isNotEmpty) {
      int val = int.parse(value);
      if (val > widget.maxSensorCount) {
        setState(
          () {
            _sensorCounterController.value = TextEditingValue(
              text: widget.maxSensorCount.toString(),
              selection: TextSelection.fromPosition(
                TextPosition(
                    offset:
                        _sensorCounterController.value.selection.baseOffset),
              ),
            );
            FocusScope.of(context).unfocus();
          },
        );
      } else {
        FocusScope.of(context).unfocus();
      }
    }
  }

  void decreaseCount(sensorCounterController) {
    FocusManager.instance.primaryFocus?.unfocus();
    int value = sensorCounterController.text.isNotEmpty
        ? int.parse(sensorCounterController.text)
        : 1;
    setState(() {
      value > 1 ? sensorCounterController.text = (--value).toString() : 1;
    });
  }

  void increaseCount(sensorCounterController) {
    FocusManager.instance.primaryFocus?.unfocus();
    int value = sensorCounterController.text.isNotEmpty
        ? int.parse(sensorCounterController.text)
        : 1;
    setState(() {
      value < widget.maxSensorCount
          ? sensorCounterController.text = (++value).toString()
          : widget.maxSensorCount;
    });
  }

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
                value: _isChecked,
                onChanged: (value) {
                  toggleChecked(value!);
                },
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: widget.iconUrl != null
                      ? Image.network(widget.iconUrl!)
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
                  child: Text(widget.name),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              AbsorbPointer(
                absorbing: !_isChecked,
                child: CustomCounter(
                  controller: _sensorCounterController,
                  active: _isChecked,
                  onChanged: limitQuantity,
                  onDecrement: () {
                    decreaseCount(_sensorCounterController);
                  },
                  onIncrement: () {
                    increaseCount(_sensorCounterController);
                  },
                ),
              )
            ],
          ),
          _sensorCounterController.text.isNotEmpty &&
                  int.parse(_sensorCounterController.text) ==
                      widget.maxSensorCount
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

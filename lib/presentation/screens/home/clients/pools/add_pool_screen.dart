import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';
import 'package:reimink_zwembaden_admin/data/models/pools_listing_screen_args.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/available_sensors_provider.dart';
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
  final FocusNode _focusNode = FocusNode();
  final List<TextEditingController> sensorIncrementControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    for (var controller in sensorIncrementControllers) {
      controller.dispose();
    }
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
            children: [
              const SizedBox(height: 10.0),
              CustomInputField(
                focusNode: _focusNode,
                controller: _poolNameController,
                label: "Pool Name",
                isObscure: false,
                icon: Icons.pool,
              ),
              const SizedBox(height: 10.0),
              Consumer(
                builder: ((context, ref, child) {
                  final sensors = ref.watch(availableSensorsProvider);
                  return sensors.when(
                    data: (data) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.sensors.length,
                          itemBuilder: (context, index) => AddSensorTile(
                            name: data.sensors[index].sensorName,
                            iconUrl: data.sensors[index].iconUrl,
                            sensorCounterController:
                                sensorIncrementControllers[index],
                          ),
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
    required this.sensorCounterController,
    this.iconUrl,
  }) : super(key: key);
  final String name;
  final String? iconUrl;
  final TextEditingController sensorCounterController;

  @override
  State<AddSensorTile> createState() => _AddSensorTileState();
}

class _AddSensorTileState extends State<AddSensorTile> {
  bool _isChecked = false;

  void toggleChecked(bool value) {
    setState(() {
      value
          ? widget.sensorCounterController.text = "1"
          : widget.sensorCounterController.clear();
      _isChecked = value;
    });
  }

  void decreaseCount(_sensorCounterController) {
    FocusManager.instance.primaryFocus?.unfocus();
    int value = _sensorCounterController.text.isNotEmpty
        ? int.parse(_sensorCounterController.text)
        : 1;
    setState(() {
      value > 1 ? _sensorCounterController.text = (--value).toString() : 1;
    });
  }

  void increaseCount(_sensorCounterController) {
    FocusManager.instance.primaryFocus?.unfocus();
    int value = _sensorCounterController.text.isNotEmpty
        ? int.parse(_sensorCounterController.text)
        : 1;
    setState(() {
      value < 9 ? _sensorCounterController.text = (++value).toString() : 9;
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
      child: Row(
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
                  ? SvgPicture.asset(widget.iconUrl!)
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
              controller: widget.sensorCounterController,
              active: _isChecked,
              onDecrement: () {
                decreaseCount(widget.sensorCounterController);
              },
              onIncrement: () {
                increaseCount(widget.sensorCounterController);
              },
            ),
          )
        ],
      ),
    );
  }
}

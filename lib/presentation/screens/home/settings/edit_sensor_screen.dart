import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/common/utils/image_picker_utils.dart';
import 'package:reimink_zwembaden_admin/common/utils/validators.dart';
import 'package:reimink_zwembaden_admin/data/models/sensor.dart';
import 'package:reimink_zwembaden_admin/data/repositories/settings_repository.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_counter.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/loader.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class EditSensorScreen extends ConsumerStatefulWidget {
  const EditSensorScreen({Key? key, required this.id, required this.sensor})
      : super(key: key);
  final Sensor sensor;
  final String id;

  @override
  _EditSensorScreenState createState() => _EditSensorScreenState();
}

class _EditSensorScreenState extends ConsumerState<EditSensorScreen> {
  final TextEditingController _sensorCounterController =
      TextEditingController(text: "1");
  final TextEditingController _sensorNameController = TextEditingController();
  final TextEditingController _setTopicController = TextEditingController();
  final TextEditingController _minSetController = TextEditingController();
  final TextEditingController _maxSetController = TextEditingController();
  final TextEditingController _mqttTopicController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final SettingsRepository settingsRepository = GetIt.I<SettingsRepository>();
  String? iconPath;
  String? iconUrl;
  bool iconUpdated = false;
  bool enableSet = false;

  @override
  void initState() {
    enableSet = widget.sensor.enableSet;
    _sensorCounterController.text = widget.sensor.maxSensorCount.toString();
    _sensorNameController.text = widget.sensor.sensorName;
    _setTopicController.text = widget.sensor.setTopic ?? "";
    widget.sensor.minSet != null
        ? _minSetController.text = widget.sensor.minSet.toString()
        : "";
    widget.sensor.maxSet != null
        ? _maxSetController.text = widget.sensor.maxSet.toString()
        : "";
    _mqttTopicController.text = widget.sensor.mqttTopic;
    iconUrl = widget.sensor.iconUrl;
    super.initState();
  }

  @override
  void dispose() {
    _sensorCounterController.dispose();
    _sensorNameController.dispose();
    _mqttTopicController.dispose();
    _setTopicController.dispose();
    _minSetController.dispose();
    _maxSetController.dispose();
    super.dispose();
  }

  void decreaseCount() {
    FocusManager.instance.primaryFocus?.unfocus();
    int value = _sensorCounterController.text.isNotEmpty
        ? int.parse(_sensorCounterController.text)
        : 1;
    setState(() {
      value > 1 ? _sensorCounterController.text = (--value).toString() : 1;
    });
  }

  void increaseCount() {
    FocusManager.instance.primaryFocus?.unfocus();
    int value = _sensorCounterController.text.isNotEmpty
        ? int.parse(_sensorCounterController.text)
        : 1;
    setState(() {
      value < 9 ? _sensorCounterController.text = (++value).toString() : 9;
    });
  }

  void pickSensorIconFromGallery() async {
    iconPath = await ImagePickerUtility().picImageFromGallery();
    setState(() {
      if (iconPath != null) {
        iconUpdated = true;
      }
    });
  }

  bool validSetValues() {
    if (enableSet) {
      final double minSet = double.parse(_minSetController.text);
      final double maxSet = double.parse(_maxSetController.text);
      if (minSet >= 0 && minSet < maxSet) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(sensorNotifierProvider, (_, ScreenState screenState) {
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
        _formKey.currentState!.reset();
        setState(() {
          iconPath = null;
        });
        Navigator.pop(context, false);
        ref.refresh(sensorsSnapshotProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(Strings.sensorUpdatedSuccessMessage),
            backgroundColor: Colors.green,
            duration: Duration(
              milliseconds: 800,
            ),
          ),
        );
      }
    });
    return Stack(
      children: [
        Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              Strings.addSensor,
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomInputField(
                              label: Strings.sensorName,
                              isObscure: false,
                              icon: Icons.sensors,
                              controller: _sensorNameController,
                              validator: InputValidator.requiredFieldValidator,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomInputField(
                              label: Strings.mqttTopic,
                              isObscure: false,
                              icon: Icons.topic,
                              controller: _mqttTopicController,
                              validator: InputValidator.requiredFieldValidator,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGrey,
                                      border: Border.all(
                                        width: 1,
                                        color: AppColors.lightBlue,
                                      ),
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(Strings.uploadSensorIcon,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2),
                                        const SizedBox(height: 5.0),
                                        Container(
                                          width: 70,
                                          height: 70,
                                          color: Colors.transparent,
                                          child: Material(
                                            color: AppColors.lightBlue,
                                            shadowColor: AppColors.blue,
                                            elevation: 3.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                7.0,
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: pickSensorIconFromGallery,
                                              splashColor:
                                                  AppColors.primary.withOpacity(
                                                0.5,
                                              ),
                                              highlightColor:
                                                  AppColors.primary.withOpacity(
                                                0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                7.0,
                                              ),
                                              child: iconUrl == null &&
                                                      iconPath != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        7.0,
                                                      ),
                                                      child: Image.file(
                                                        File(iconPath!),
                                                      ),
                                                    )
                                                  : iconUrl != null &&
                                                          iconPath == null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            7.0,
                                                          ),
                                                          child: Image.network(
                                                            iconUrl!,
                                                          ),
                                                        )
                                                      : iconUrl != null &&
                                                              iconPath != null
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                7.0,
                                                              ),
                                                              child: Image.file(
                                                                File(iconPath!),
                                                              ),
                                                            )
                                                          : const Center(
                                                              child: Icon(
                                                                Icons
                                                                    .add_a_photo,
                                                                color: AppColors
                                                                    .blue,
                                                              ),
                                                            ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGrey,
                                      border: Border.all(
                                        width: 1,
                                        color: AppColors.lightBlue,
                                      ),
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(Strings.maxSensorCount,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2),
                                        const SizedBox(height: 5.0),
                                        SizedBox(
                                          height: 70,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: CustomCounter(
                                              size: const Size(34, 34),
                                              controller:
                                                  _sensorCounterController,
                                              onChanged: (value) {},
                                              onDecrement: decreaseCount,
                                              onIncrement: increaseCount,
                                              active: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: enableSet,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == false) {
                                          _setTopicController.clear();
                                          _minSetController.clear();
                                          _maxSetController.clear();
                                        }
                                        if (value == true) {
                                          _setTopicController.text =
                                              widget.sensor.setTopic ?? "";
                                          widget.sensor.minSet != null
                                              ? _minSetController.text = widget
                                                  .sensor.minSet
                                                  .toString()
                                              : "";
                                          widget.sensor.maxSet != null
                                              ? _maxSetController.text = widget
                                                  .sensor.maxSet
                                                  .toString()
                                              : "";
                                        }
                                        enableSet = value ?? false;
                                      });
                                    }),
                                const Text(Strings.enableSetValue),
                              ],
                            ),
                            Opacity(
                              opacity: enableSet ? 1 : 0.5,
                              child: AbsorbPointer(
                                absorbing: !enableSet,
                                child: Column(
                                  children: [
                                    CustomInputField(
                                        disabled: !enableSet,
                                        label: Strings.setTopic,
                                        isObscure: false,
                                        icon: Icons.sensors,
                                        controller: _setTopicController,
                                        validator: enableSet
                                            ? InputValidator
                                                .requiredFieldValidator
                                            : InputValidator.clear),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: CustomInputField(
                                            disabled: !enableSet,
                                            label: Strings.minSet,
                                            isObscure: false,
                                            icon: Icons.sensors,
                                            controller: _minSetController,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(),
                                            validator: enableSet
                                                ? InputValidator
                                                    .requiredFieldValidator
                                                : InputValidator.clear,
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Flexible(
                                          child: CustomInputField(
                                            disabled: !enableSet,
                                            label: Strings.maxSet,
                                            isObscure: false,
                                            icon: Icons.sensors,
                                            controller: _maxSetController,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(),
                                            validator: enableSet
                                                ? InputValidator
                                                    .requiredFieldValidator
                                                : InputValidator.clear,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    PrimaryButton(
                      label: "Save",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (validSetValues()) {
                            ref
                                .watch(sensorNotifierProvider.notifier)
                                .editSensor(
                                  id: widget.id,
                                  iconUpdated: iconUpdated,
                                  sensorName: _sensorNameController.text,
                                  mqttTopic: _mqttTopicController.text,
                                  enableSet: enableSet,
                                  setTopic: _setTopicController.text,
                                  minSet:
                                      _minSetController.text.trim().isNotEmpty
                                          ? double.parse(_minSetController.text)
                                          : null,
                                  maxSet:
                                      _maxSetController.text.trim().isNotEmpty
                                          ? double.parse(_maxSetController.text)
                                          : null,
                                  maxSensorCount:
                                      int.parse(_sensorCounterController.text),
                                  iconPath: iconPath,
                                  iconUrl: iconUrl,
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  Strings.invalidSetValuesError,
                                ),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, _) {
            var screenState = ref.watch(sensorNotifierProvider);
            if (screenState.stateType == StateType.loading) {
              return const Loader();
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

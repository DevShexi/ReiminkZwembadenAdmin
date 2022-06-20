import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/common/utils/image_picker_utils.dart';
import 'package:reimink_zwembaden_admin/common/utils/validators.dart';
import 'package:reimink_zwembaden_admin/data/models/available_sensors.dart';
import 'package:reimink_zwembaden_admin/data/repositories/settings_repository.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/settings_provider.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_counter.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/loader.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class AddSensorScreen extends ConsumerStatefulWidget {
  const AddSensorScreen({Key? key}) : super(key: key);

  @override
  _AddSensorScreenState createState() => _AddSensorScreenState();
}

class _AddSensorScreenState extends ConsumerState<AddSensorScreen> {
  final TextEditingController _sensorCounterController =
      TextEditingController(text: "1");
  final TextEditingController _sensorNameController = TextEditingController();
  final TextEditingController _mqttTopicController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final SettingsRepository settingsRepository = GetIt.I<SettingsRepository>();
  String? iconPath;

  @override
  void dispose() {
    _sensorCounterController.dispose();
    _sensorNameController.dispose();
    _mqttTopicController.dispose();
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addNewSensorNotifierProvider, (_, ScreenState screenState) {
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
        ref.refresh(sensorCountProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(Strings.sensorAddedSuccessMessage),
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
          resizeToAvoidBottomInset: false,
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
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  Strings.uploadSensorIcon,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  color: Colors.transparent,
                                  child: Material(
                                    color: AppColors.lightBlue,
                                    shadowColor: AppColors.blue,
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
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
                                      borderRadius: BorderRadius.circular(
                                        7.0,
                                      ),
                                      child: iconPath != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                7.0,
                                              ),
                                              child: Image.file(
                                                File(iconPath!),
                                              ),
                                            )
                                          : const Center(
                                              child: Icon(
                                                Icons.add_a_photo,
                                                color: AppColors.blue,
                                              ),
                                            ),
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
                                Text(
                                  Strings.maxSensorCount,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomCounter(
                              size: const Size(34, 34),
                              controller: _sensorCounterController,
                              onDecrement: decreaseCount,
                              onIncrement: increaseCount,
                              active: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    PrimaryButton(
                      label: "Save",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .watch(addNewSensorNotifierProvider.notifier)
                              .addSensor(
                                sensorName: _sensorNameController.text,
                                mqttTopic: _mqttTopicController.text,
                                maxSensorCount:
                                    int.parse(_sensorCounterController.text),
                                iconPath: iconPath,
                              );
                          // final sensor = AvailableSensor(
                          //   sensorName: _sensorNameController.text,
                          //   mqttTopic: _mqttTopicController.text,
                          //   maxSensorCount:
                          //       int.parse(_sensorCounterController.text),
                          // );
                          // await settingsRepository.addNewSensor(sensor);
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
            var screenState = ref.watch(addNewSensorNotifierProvider);
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

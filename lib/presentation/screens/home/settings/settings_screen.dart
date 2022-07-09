import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_alert_dialog.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_elevated_button.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/loader.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      } else if (screenState.stateType == StateType.success) {}
    });
    final sensorCount = ref.watch(sensorsSnapshotProvider);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.backgroundGrey,
          appBar: AppBar(
            backgroundColor: AppColors.lightGrey,
            title: const Text(Strings.settings),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      label: Strings.logout,
                      promptMessage: Strings.logoutPromptMessage,
                      actionLabel: Strings.logout,
                      action: () {
                        ref.watch(logOutNotifierProvider.notifier).logout();
                        Navigator.pop(context, false);
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      Strings.adminSettings,
                      style: AppStyles.body,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SettingsCard(
                        stat: "23",
                        label: Strings.clients,
                        actionLabel: Strings.add,
                        addNewaction: () {},
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            PagePath.clients,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    sensorCount.when(
                      data: (data) => Expanded(
                        child: SettingsCard(
                          stat: data.docs.length.toString(),
                          label: Strings.sensors,
                          actionLabel: Strings.add,
                          addNewaction: () {
                            Navigator.of(context).pushNamed(
                              PagePath.addSensor,
                            );
                          },
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PagePath.sensors,
                            );
                          },
                        ),
                      ),
                      error: (err, stack) => const SizedBox.shrink(),
                      loading: () => Expanded(
                        child: SettingsCard(
                          stat: "",
                          label: Strings.sensors,
                          actionLabel: Strings.add,
                          addNewaction: () {
                            Navigator.of(context).pushNamed(
                              PagePath.addSensor,
                            );
                          },
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PagePath.sensors,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, _) {
            var screenState = ref.watch(logOutNotifierProvider);
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

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    Key? key,
    required this.stat,
    required this.label,
    required this.actionLabel,
    required this.addNewaction,
    this.onTap,
  }) : super(key: key);
  final String stat;
  final String label;
  final String actionLabel;
  final Function() addNewaction;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              7.0,
            ),
          ),
          color: AppColors.white,
          shadowColor: AppColors.lightBlue,
          elevation: 3.0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat,
                  style: AppStyles.heading1primary,
                ),
                Text(
                  label,
                  style: AppStyles.body,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomElevatedButton(
                      label: actionLabel,
                      onPressed: addNewaction,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

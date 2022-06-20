import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/data/repositories/admin_repository.dart';
import 'package:reimink_zwembaden_admin/data/repositories/settings_repository.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';

class AddNewSensorNotifier extends StateNotifier<ScreenState> {
  AddNewSensorNotifier({
    required this.settingsRepository,
  }) : super(ScreenState.initial());
  final SettingsRepository settingsRepository;

  Future<void> addSensor({
    required String sensorName,
    required String mqttTopic,
    required int? maxSensorCount,
    String? iconPath,
  }) async {
    String? downloadUrl;
    state = ScreenState.loading();

    try {
      if (iconPath != null) {
        downloadUrl =
            await settingsRepository.uploadSensorIconToStorage(File(iconPath));
      }
      final Sensor newSensor = Sensor(
        sensorName: sensorName,
        mqttTopic: mqttTopic,
        maxSensorCount: maxSensorCount,
        iconUrl: downloadUrl,
      );
      await settingsRepository.addNewSensor(newSensor);
      state = ScreenState.success(
        Strings.sensorAddedSuccessMessage,
      );
    } catch (e) {
      state = ScreenState.error(
        e.toString(),
      );
    }
  }
}

final addNewSensorNotifierProvider =
    StateNotifierProvider.autoDispose<AddNewSensorNotifier, ScreenState>(
  (ref) => AddNewSensorNotifier(
    settingsRepository: GetIt.I<SettingsRepository>(),
  ),
);

final sensorsProvider = FutureProvider.autoDispose(
  (ref) {
    return GetIt.I<SettingsRepository>().getAllSensors();
  },
);

final sensorCountProvider = FutureProvider.autoDispose(
  (ref) {
    return GetIt.I<SettingsRepository>().getAllSensorsCount();
  },
);

class LogoutNotifier extends StateNotifier<ScreenState> {
  LogoutNotifier({required this.adminRepository})
      : super(ScreenState.initial());
  final AdminRepository adminRepository;
  Future<void> logout() async {
    await adminRepository.logout();
  }
}

final logOutNotifierProvider =
    StateNotifierProvider<LogoutNotifier, ScreenState>(
  (ref) => LogoutNotifier(
    adminRepository: GetIt.I<AdminRepository>(),
  ),
);

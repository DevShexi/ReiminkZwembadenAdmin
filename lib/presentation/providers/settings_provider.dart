import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/common/utils/storage_utils.dart';
import 'package:reimink_zwembaden_admin/data/models/models.dart';
import 'package:reimink_zwembaden_admin/data/repositories/admin_repository.dart';
import 'package:reimink_zwembaden_admin/data/repositories/settings_repository.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';

class SensorNotifier extends StateNotifier<ScreenState> {
  SensorNotifier({
    required this.settingsRepository,
    required this.storageUtils,
  }) : super(ScreenState.initial());
  final SettingsRepository settingsRepository;
  final StorageUtils storageUtils;

  Future<void> addSensor({
    required String sensorName,
    required String mqttTopic,
    required bool enableSet,
    required int? maxSensorCount,
    String? iconPath,
    String? setTopic,
    double? minSet,
    double? maxSet,
  }) async {
    String? downloadUrl;
    state = ScreenState.loading();

    try {
      if (iconPath != null) {
        downloadUrl = await storageUtils.uploadImageToStorage(File(iconPath));
      }
      final Sensor newSensor = Sensor(
          sensorName: sensorName,
          mqttTopic: mqttTopic,
          enableSet: enableSet,
          maxSensorCount: maxSensorCount,
          setTopic: setTopic,
          minSet: minSet,
          maxSet: maxSet,
          iconUrl: downloadUrl);
      await settingsRepository.addNewSensor(newSensor);
      state = ScreenState.success(Strings.sensorAddedSuccessMessage);
    } catch (e) {
      state = ScreenState.error(e.toString());
    }
  }

  Future<void> editSensor({
    required String id,
    required String sensorName,
    required String mqttTopic,
    required bool enableSet,
    required int? maxSensorCount,
    required bool iconUpdated,
    String? iconPath,
    String? iconUrl,
    String? setTopic,
    double? minSet,
    double? maxSet,
  }) async {
    String? downloadUrl;
    state = ScreenState.loading();
    final Sensor sensor;
    try {
      if (iconUpdated && iconPath != null) {
        if (iconUrl != null) {
          await storageUtils.deleteImageFromStorage(iconUrl);
        }
        downloadUrl = await storageUtils.uploadImageToStorage(File(iconPath));
        sensor = Sensor(
            sensorName: sensorName,
            mqttTopic: mqttTopic,
            enableSet: enableSet,
            maxSensorCount: maxSensorCount,
            setTopic: setTopic,
            minSet: minSet,
            maxSet: maxSet,
            iconUrl: downloadUrl);
      } else {
        sensor = Sensor(
          sensorName: sensorName,
          mqttTopic: mqttTopic,
          enableSet: enableSet,
          maxSensorCount: maxSensorCount,
          setTopic: setTopic,
          minSet: minSet,
          maxSet: maxSet,
          iconUrl: iconUrl,
        );
      }
      await settingsRepository.updateSensor(id, sensor);
      state = ScreenState.success(Strings.sensorUpdatedSuccessMessage);
    } catch (e) {
      state = ScreenState.error(e.toString());
    }
  }

  Future<void> deleteSensor(String id) async {
    return await settingsRepository.deleteSensor(id);
  }
}

final sensorNotifierProvider =
    StateNotifierProvider.autoDispose<SensorNotifier, ScreenState>(
  (ref) => SensorNotifier(
    settingsRepository: GetIt.I<SettingsRepository>(),
    storageUtils: GetIt.I<StorageUtils>(),
  ),
);

final sensorsSnapshotProvider = StreamProvider.autoDispose(
  (ref) {
    return GetIt.I<SettingsRepository>().getSensorsSnapshot();
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

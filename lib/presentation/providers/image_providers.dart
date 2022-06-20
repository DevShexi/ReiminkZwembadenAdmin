import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/repositories/admin_repository.dart';
import 'package:reimink_zwembaden_admin/data/repositories/settings_repository.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';

import '../../data/models/network/network_models.dart';

final sensorIconWithUrlProvider = StateProvider.autoDispose<SensorIconWithUrl?>(
  (ref) => null,
);

class SensorIconUrlNotifier extends StateNotifier<ScreenState<File>> {
  final AdminRepository adminRepository;
  final SettingsRepository settingsRepository;

  SensorIconUrlNotifier({
    required this.adminRepository,
    required this.settingsRepository,
  }) : super(ScreenState.initial());

  String? coverPhotoURL;

  Future<void> uploadCoverPhotoToStorage(File image) async {
    try {
      state = ScreenState.loading();
      String? id = adminRepository.getUserEmail();
      if (id != null) {
        String path = 'trainers/cover_photos/$id';
        final url = await settingsRepository.uploadSensorIconToStorage(image);
        state = ScreenState<File>.success(image);
      } else {
        state = ScreenState.error("There was an error in uploading the image");
      }
    } on FirebaseException catch (e) {
      state = ScreenState.error(e.message);
    }
  }
}

final sensorIconUrlProvider =
    StateNotifierProvider.autoDispose<SensorIconUrlNotifier, ScreenState<File>>(
  (ref) => SensorIconUrlNotifier(
    adminRepository: GetIt.I<AdminRepository>(),
    settingsRepository: GetIt.I<SettingsRepository>(),
  ),
);

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:reimink_zwembaden_admin/data/models/available_sensors.dart';

abstract class LocalDataSource {
  Future<Sensors> getAvailablePools();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<Sensors> getAvailablePools() async {
    final content = json.decode(
      await rootBundle.loadString('assets/json/available_sensors.json'),
    ) as Map<String, Object?>;
    return Sensors.fromJson(content);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/data/models/pool_sensor.dart';

final poolSensorProvider = StateProvider.autoDispose<List<PoolSensor>>(
  (ref) => [],
);

final clientIdProvider = StateProvider<String?>((ref) => null);
final clientNameProvider = StateProvider<String?>((ref) => null);
final poolNameProvider = StateProvider<String?>((ref) => null);
final poolTopicProvider = StateProvider<String?>((ref) => null);

import 'package:json_annotation/json_annotation.dart';
import 'package:reimink_zwembaden_admin/data/models/pool_sensor.dart';
part 'client_pool.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ClientPool {
  ClientPool({
    required this.clientName,
    required this.clientId,
    required this.poolName,
    required this.poolTopic,
    required this.poolSensors,
  });
  String clientName;
  String clientId;
  String poolName;
  String? poolTopic;
  List<PoolSensor> poolSensors;

  factory ClientPool.fromJson(Map<String, dynamic> json) =>
      _$ClientPoolFromJson(json);
  Map<String, dynamic> toJson() => _$ClientPoolToJson(this);
}

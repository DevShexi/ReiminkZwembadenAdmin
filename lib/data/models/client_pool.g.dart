// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_pool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientPool _$ClientPoolFromJson(Map<String, dynamic> json) => ClientPool(
      clientName: json['client_name'] as String,
      clientId: json['client_id'] as String,
      poolName: json['pool_name'] as String,
      poolTopic: json['pool_topic'] as String?,
      poolSensors: (json['pool_sensors'] as List<dynamic>)
          .map((e) => PoolSensor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientPoolToJson(ClientPool instance) =>
    <String, dynamic>{
      'client_name': instance.clientName,
      'client_id': instance.clientId,
      'pool_name': instance.poolName,
      'pool_topic': instance.poolTopic,
      'pool_sensors': instance.poolSensors.map((e) => e.toJson()).toList(),
    };

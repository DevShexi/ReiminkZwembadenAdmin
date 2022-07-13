// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pool_sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoolSensor _$PoolSensorFromJson(Map<String, dynamic> json) => PoolSensor(
      sensorName: json['sensor_name'] as String,
      mqttTopic: json['mqtt_topic'] as String,
      enableSet: json['enable_set'] as bool,
      count: json['count'] as int,
      setTopic: json['set_topic'] as String?,
      minSet: (json['min_set'] as num?)?.toDouble(),
      maxSet: (json['max_set'] as num?)?.toDouble(),
      iconUrl: json['icon_url'] as String?,
      isSelected: json['is_selected'] as bool?,
      maxSensorCount: json['max_sensor_count'] as int?,
    );

Map<String, dynamic> _$PoolSensorToJson(PoolSensor instance) =>
    <String, dynamic>{
      'sensor_name': instance.sensorName,
      'mqtt_topic': instance.mqttTopic,
      'enable_set': instance.enableSet,
      'set_topic': instance.setTopic,
      'min_set': instance.minSet,
      'max_set': instance.maxSet,
      'icon_url': instance.iconUrl,
      'count': instance.count,
      'max_sensor_count': instance.maxSensorCount,
      'is_selected': instance.isSelected,
    };

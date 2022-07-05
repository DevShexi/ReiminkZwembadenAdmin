// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensor _$SensorFromJson(Map<String, dynamic> json) => Sensor(
      sensorName: json['sensor_name'] as String,
      mqttTopic: json['mqtt_topic'] as String,
      setTopic: json['set_topic'] as String?,
      minSet: (json['min_set'] as num?)?.toDouble(),
      maxSet: (json['max_set'] as num?)?.toDouble(),
      iconUrl: json['icon_url'] as String?,
      maxSensorCount: json['max_sensor_count'] as int?,
    );

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
      'sensor_name': instance.sensorName,
      'mqtt_topic': instance.mqttTopic,
      'set_topic': instance.setTopic,
      'min_set': instance.minSet,
      'max_set': instance.maxSet,
      'icon_url': instance.iconUrl,
      'max_sensor_count': instance.maxSensorCount,
    };

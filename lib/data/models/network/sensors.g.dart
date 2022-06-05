// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensors _$SensorsFromJson(Map<String, dynamic> json) => Sensors(
      sensors: (json['sensors'] as List<dynamic>)
          .map((e) => Sensor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SensorsToJson(Sensors instance) => <String, dynamic>{
      'sensors': instance.sensors,
    };

Sensor _$SensorFromJson(Map<String, dynamic> json) => Sensor(
      name: json['name'] as String,
      isOn: json['isOn'] as bool,
    );

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
      'name': instance.name,
      'isOn': instance.isOn,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatabaseConfig _$DatabaseConfigFromJson(Map<String, dynamic> json) =>
    DatabaseConfig(
      hostName: json['host_name'] as String,
      port: json['port'] as String,
      userName: json['user_name'] as String,
      databaseName: json['database_name'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$DatabaseConfigToJson(DatabaseConfig instance) =>
    <String, dynamic>{
      'host_name': instance.hostName,
      'port': instance.port,
      'user_name': instance.userName,
      'database_name': instance.databaseName,
      'password': instance.password,
    };

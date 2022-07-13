import 'package:json_annotation/json_annotation.dart';
part 'database_config.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class DatabaseConfig {
  const DatabaseConfig({
    required this.hostName,
    required this.port,
    required this.userName,
    required this.databaseName,
    required this.password,
  });
  final String hostName;
  final String port;
  final String userName;
  final String databaseName;
  final String password;

  factory DatabaseConfig.fromJson(Map<String, dynamic> json) =>
      _$DatabaseConfigFromJson(json);
  Map<String, dynamic> toJson() => _$DatabaseConfigToJson(this);
}

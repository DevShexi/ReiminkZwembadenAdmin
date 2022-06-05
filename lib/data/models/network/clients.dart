import 'package:json_annotation/json_annotation.dart';

part 'clients.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Clients {
  const Clients({
    required this.requests,
    required this.approvedClients,
    required this.rejectedClients,
  });
  final List<Client> requests;
  final List<Client> approvedClients;
  final List<Client> rejectedClients;

  factory Clients.fromJson(Map<String, dynamic> json) =>
      _$ClientsFromJson(json);
  Map<String, dynamic> toJson() => _$ClientsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Client {
  Client({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl,
  });
  final String id;
  final String name;
  final String email;
  final String? imageUrl;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

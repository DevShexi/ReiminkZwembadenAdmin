// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clients _$ClientsFromJson(Map<String, dynamic> json) => Clients(
      requests: (json['requests'] as List<dynamic>)
          .map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList(),
      approvedClients: (json['approved_clients'] as List<dynamic>)
          .map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList(),
      rejectedClients: (json['rejected_clients'] as List<dynamic>)
          .map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientsToJson(Clients instance) => <String, dynamic>{
      'requests': instance.requests,
      'approved_clients': instance.approvedClients,
      'rejected_clients': instance.rejectedClients,
    };

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      clientId: json['client_id'] as String,
      clientName: json['client_name'] as String,
      clientEmail: json['client_email'] as String,
      imageUrl: json['image_url'] as String?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'client_id': instance.clientId,
      'client_name': instance.clientName,
      'client_email': instance.clientEmail,
      'image_url': instance.imageUrl,
      'status': instance.status,
    };

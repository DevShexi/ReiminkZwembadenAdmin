import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/data/models/network/clients.dart';

Clients? clients;

final clientsProvider = FutureProvider.autoDispose
    .family<List<Client>, String>((ref, clientType) async {
  final content = json.decode(
    await rootBundle.loadString('assets/mockJsonResponses/clients.json'),
  ) as Map<String, Object?>;
  final List<Client> response = [];
  final clients = Clients.fromJson(content);
  switch (clientType) {
    case Strings.rejectedClientType:
      response.addAll(clients.rejectedClients);
      break;
    case Strings.requestClientType:
      response.addAll(clients.requests);
      break;
    default:
      response.addAll(clients.approvedClients);
  }
  await Future.delayed(const Duration(milliseconds: 500));
  return response;
});

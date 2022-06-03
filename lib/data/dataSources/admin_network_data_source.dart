import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/models/network/network_models.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';

abstract class AdminNetworkDataSource {
  Future? login(AuthRequest loginRequest);
  Future? register(AuthRequest registerRequest);
  Future<bool> forgotPassword(String email);
  Future logout();
}

class AdminNetworkDataSourceImpl implements AdminNetworkDataSource {
  final ApiClient _apiClient;
  AdminNetworkDataSourceImpl() : _apiClient = GetIt.I<ApiClient>();
  @override
  Future? login(AuthRequest loginRequest) async {
    final LoginResponse response = await _apiClient.login(loginRequest);
    return response;
  }

  @override
  Future? register(AuthRequest loginRequest) async {
    final RegisterResponse response = await _apiClient.register(loginRequest);
    return response;
  }

  @override
  Future<bool> forgotPassword(String email) async {
    final response = await _apiClient.forgotPassword(email);
    return response;
  }

  @override
  Future<void> logout() async {
    final response = await _apiClient.logout();
    return response;
  }
}

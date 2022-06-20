import 'package:reimink_zwembaden_admin/data/dataSources/admin_network_data_source.dart';
import 'package:reimink_zwembaden_admin/data/models/network/network_models.dart';

abstract class AdminRepository {
  Future<LoginResponse> login(AuthRequest loginRequest);
  Future<RegisterResponse> register(AuthRequest registerRequest);
  Future<bool> forgotPassword(String email);
  Future<void> logout();
  String? getUserEmail();
  String? getUserId();
}

class AdminRepositoryImpl implements AdminRepository {
  final AdminNetworkDataSource adminNetworkDataSource;
  AdminRepositoryImpl({required this.adminNetworkDataSource});

  @override
  Future<LoginResponse> login(AuthRequest loginRequest) async {
    final LoginResponse response =
        await adminNetworkDataSource.login(loginRequest);
    return response;
  }

  @override
  Future<RegisterResponse> register(AuthRequest registerRequest) async {
    final RegisterResponse response =
        await adminNetworkDataSource.register(registerRequest);
    return response;
  }

  @override
  Future<bool> forgotPassword(String email) async {
    final bool response = await adminNetworkDataSource.forgotPassword(email);
    return response;
  }

  @override
  Future<void> logout() async {
    final response = await adminNetworkDataSource.logout();
    return response;
  }

  @override
  String? getUserEmail() {
    final String? email = adminNetworkDataSource.getUserEmail();
    return email;
  }

  @override
  String? getUserId() {
    final String? uid = adminNetworkDataSource.getUserId();
    return uid;
  }
}

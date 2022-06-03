import 'package:reimink_zwembaden_admin/data/dataSources/admin_network_data_source.dart';
import 'package:reimink_zwembaden_admin/data/repositories/admin_repository.dart';
import 'package:reimink_zwembaden_admin/network/api_client.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._();
  static final _dependency = GetIt.instance;

  static void setUpLocator() {
    _setUpApiClient();
    _setUpAdminNetworkDataSource();
    _setUpAdminRepository();
  }

  static void _setUpApiClient() {
    _dependency.registerFactory<ApiClient>(
      () => ApiClientImpl(),
    );
  }

  static void _setUpAdminNetworkDataSource() {
    _dependency.registerFactory<AdminNetworkDataSource>(
      () => AdminNetworkDataSourceImpl(),
    );
  }

  static void _setUpAdminRepository() {
    _dependency.registerFactory<AdminRepository>(
      () => AdminRepositoryImpl(
        adminNetworkDataSource: _dependency(),
      ),
    );
  }
}

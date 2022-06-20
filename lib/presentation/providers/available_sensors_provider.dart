import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/data/dataSources/local_data_source.dart';

final availableSensorsProvider = FutureProvider((_) async {
  final localDataSource = GetIt.I<LocalDataSource>();
  return await localDataSource.getAvailablePools();
});

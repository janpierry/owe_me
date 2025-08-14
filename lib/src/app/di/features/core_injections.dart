import 'package:get_it/get_it.dart';
import 'package:owe_me/src/data/data_sources/app_data_base.dart';

void initCoreInjections() {
  final inj = GetIt.instance;

  inj.registerLazySingleton<AppDatabase>(() => AppDatabase());
}

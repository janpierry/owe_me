import 'package:get_it/get_it.dart';
import 'package:owe_me/src/data/data_sources/owe_record_data_source.dart';

void initOweRecordInjections() {
  final inj = GetIt.instance;

  //Blocs

  //Use Cases

  //Repositories

  //Data Sources
  inj.registerLazySingleton<OweRecordDataSource>(
    () => OweRecordDataSourceImpl(oweMeDatabase: inj()),
  );
}

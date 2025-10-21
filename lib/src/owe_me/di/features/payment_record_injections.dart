import 'package:get_it/get_it.dart';
import 'package:owe_me/src/data/data_sources/payment_record_data_source.dart';

void initPaymentRecordInjections() {
  final inj = GetIt.instance;

  //Blocs

  //Use Cases

  //Repositories

  //Data Sources
  inj.registerLazySingleton<PaymentRecordDataSource>(
    () => PaymentRecordDataSourceImpl(oweMeDatabase: inj()),
  );
}

import 'package:get_it/get_it.dart';
import 'package:owe_me/src/data/data_sources/monetary_record_data_source.dart';
import 'package:owe_me/src/data/repositories/monetary_record_repository_impl.dart';
import 'package:owe_me/src/domain/repositories/monetary_record_repository.dart';
import 'package:owe_me/src/domain/use_cases/debtor/edit_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/remove_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/load_debtor_monetary_record_history.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/remove_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/presentation/blocs/debtor/debtor_bloc.dart';

void initMonetaryRecordInjections() {
  final inj = GetIt.instance;

  //Blocs
  inj.registerFactory<DebtorBloc>(
    () => DebtorBloc(
      loadDebtorMonetaryRecordHistory: inj(),
      editDebtor: inj(),
      removeDebtor: inj(),
      removeMonetaryRecordAndUpdateDebtor: inj(),
    ),
  );

  //Use Cases
  inj.registerLazySingleton<LoadDebtorMonetaryRecordHistory>(
    () => LoadDebtorMonetaryRecordHistory(repository: inj()),
  );
  inj.registerLazySingleton<AddMonetaryRecordAndUpdateDebtor>(
    () => AddMonetaryRecordAndUpdateDebtor(repository: inj()),
  );
  inj.registerLazySingleton<EditMonetaryRecordAndUpdateDebtor>(
    () => EditMonetaryRecordAndUpdateDebtor(repository: inj()),
  );
  inj.registerLazySingleton<RemoveMonetaryRecordAndUpdateDebtor>(
    () => RemoveMonetaryRecordAndUpdateDebtor(repository: inj()),
  );
  inj.registerLazySingleton<EditDebtor>(
    () => EditDebtor(repository: inj()),
  );
  inj.registerLazySingleton<RemoveDebtor>(
    () => RemoveDebtor(repository: inj()),
  );

  //Repositories
  inj.registerLazySingleton<MonetaryRecordRepository>(
    () => MonetaryRecordRepositoryImpl(
      monetaryRecordDataSource: inj(),
    ),
  );

  //Data Sources
  inj.registerLazySingleton<MonetaryRecordDataSource>(
    () => MonetaryRecordDataSourceImpl(
      appDatabase: inj(),
      oweRecordDataSource: inj(),
      paymentRecordDataSource: inj(),
    ),
  );
}

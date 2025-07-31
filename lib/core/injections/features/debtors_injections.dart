import 'package:get_it/get_it.dart';
import 'package:owe_me/data/data_sources/debtor_data_source.dart';
import 'package:owe_me/data/repositories/debtor_repository_impl.dart';
import 'package:owe_me/domain/repositories/debtor_repository.dart';
import 'package:owe_me/domain/use_cases/debtor/add_debtor.dart';
import 'package:owe_me/domain/use_cases/debtor/load_debtors.dart';
import 'package:owe_me/presentation/blocs/debtors/debtors_bloc.dart';

void initDebtorsInjections() {
  final inj = GetIt.instance;

  //Blocs
  inj.registerFactory<DebtorsBloc>(
    () => DebtorsBloc(loadDebtors: inj(), addDebtor: inj()),
  );

  //Use Cases
  inj.registerLazySingleton<LoadDebtors>(() => LoadDebtors(repository: inj()));
  inj.registerLazySingleton<AddDebtor>(() => AddDebtor(repository: inj()));

  //Repositories
  inj.registerLazySingleton<DebtorRepository>(
    () => DebtorRepositoryImpl(debtorDataSource: inj()),
  );

  //Data Sources
  inj.registerLazySingleton<DebtorDataSource>(
      () => DebtorDataSourceImpl(appDatabase: inj()));
}

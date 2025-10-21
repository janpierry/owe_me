import 'package:get_it/get_it.dart';
import 'package:owe_me/src/data/data_sources/debtor_data_source.dart';
import 'package:owe_me/src/data/repositories/debtor_repository_impl.dart';
import 'package:owe_me/src/domain/repositories/debtor_repository.dart';
import 'package:owe_me/src/domain/use_cases/debtor/add_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/load_debtors.dart';
import 'package:owe_me/src/presentation/blocs/debtor_selection/debtor_selection_bloc.dart';
import 'package:owe_me/src/presentation/blocs/home_debtors/home_debtors_bloc.dart';

void initDebtorsInjections() {
  final inj = GetIt.instance;

  //Blocs
  inj.registerFactory<HomeDebtorsBloc>(
    () => HomeDebtorsBloc(loadDebtors: inj(), addDebtor: inj()),
  );
  inj.registerFactory<DebtorSelectionBloc>(
    () => DebtorSelectionBloc(loadDebtors: inj()),
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
      () => DebtorDataSourceImpl(oweMeDatabase: inj()));
}

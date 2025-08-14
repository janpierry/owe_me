import 'package:get_it/get_it.dart';
import 'package:owe_me/src/data/data_sources/favorite_description_data_source.dart';
import 'package:owe_me/src/data/repositories/favorite_description_repository_impl.dart';
import 'package:owe_me/src/domain/repositories/favorite_description_repository.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/add_favorite_description.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/load_debtor_favorite_credits.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/load_debtor_favorite_debts.dart';

void initFavoriteDescriptionInjections() {
  final inj = GetIt.instance;

  //Blocs

  //Use Cases
  inj.registerLazySingleton<AddFavoriteDescription>(
    () => AddFavoriteDescription(repository: inj()),
  );
  inj.registerLazySingleton<LoadDebtorFavoriteCredits>(
    () => LoadDebtorFavoriteCredits(repository: inj()),
  );
  inj.registerLazySingleton<LoadDebtorFavoriteDebts>(
    () => LoadDebtorFavoriteDebts(repository: inj()),
  );

  //Repositories
  inj.registerLazySingleton<FavoriteDescriptionRepository>(
    () => FavoriteDescriptionRepositoryImpl(favoriteDescriptionDataSource: inj()),
  );

  //Data Sources
  inj.registerLazySingleton<FavoriteDescriptionDataSource>(
    () => FavoriteDescriptionDataSourceImpl(appDatabase: inj()),
  );
}

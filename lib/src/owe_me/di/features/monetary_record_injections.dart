import 'package:get_it/get_it.dart';
import 'package:owe_me/src/data/data_sources/monetary_record_data_source.dart';
import 'package:owe_me/src/data/data_sources/owe_record_data_source.dart';
import 'package:owe_me/src/data/data_sources/payment_record_data_source.dart';
import 'package:owe_me/src/data/repositories/monetary_record_repository_impl.dart';
import 'package:owe_me/src/domain/repositories/monetary_record_repository.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/load_debtor_monetary_record_history.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/remove_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/amount_step/set_owe_record_amount_step_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';

void initMonetaryRecordInjections() {
  final inj = GetIt.instance;

  //Blocs
  inj
    ..registerFactory<SetOweRecordAmountStepBloc>(
      () => SetOweRecordAmountStepBloc(),
    )
    ..registerFactory<SetOweRecordInfoReviewBloc>(
      () => SetOweRecordInfoReviewBloc(
        addMonetaryRecordAndUpdateDebtor: inj(),
        editMonetaryRecordAndUpdateDebtor: inj(),
      ),
    )
    ..registerFactory<SetPaymentRecordInfoReviewBloc>(
      () => SetPaymentRecordInfoReviewBloc(
        addMonetaryRecordAndUpdateDebtor: inj(),
        editMonetaryRecordAndUpdateDebtor: inj(),
      ),
    );

  //Use Cases
  inj
    ..registerLazySingleton<LoadDebtorMonetaryRecordHistory>(
      () => LoadDebtorMonetaryRecordHistory(repository: inj()),
    )
    ..registerLazySingleton<AddMonetaryRecordAndUpdateDebtor>(
      () => AddMonetaryRecordAndUpdateDebtor(repository: inj()),
    )
    ..registerLazySingleton<EditMonetaryRecordAndUpdateDebtor>(
      () => EditMonetaryRecordAndUpdateDebtor(repository: inj()),
    )
    ..registerLazySingleton<RemoveMonetaryRecordAndUpdateDebtor>(
      () => RemoveMonetaryRecordAndUpdateDebtor(repository: inj()),
    );

  //Repositories
  inj.registerLazySingleton<MonetaryRecordRepository>(
    () => MonetaryRecordRepositoryImpl(
      monetaryRecordDataSource: inj(),
    ),
  );

  //Data Sources
  inj
    ..registerLazySingleton<MonetaryRecordDataSource>(
      () => MonetaryRecordDataSourceImpl(
        oweMeDatabase: inj(),
        oweRecordDataSource: inj(),
        paymentRecordDataSource: inj(),
      ),
    )
    ..registerLazySingleton<OweRecordDataSource>(
      () => OweRecordDataSourceImpl(oweMeDatabase: inj()),
    )
    ..registerLazySingleton<PaymentRecordDataSource>(
      () => PaymentRecordDataSourceImpl(oweMeDatabase: inj()),
    );
}

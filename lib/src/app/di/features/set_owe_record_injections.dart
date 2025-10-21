import 'package:get_it/get_it.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/amount_step/set_owe_record_amount_step_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';

void initSetOweRecordInjections() {
  final inj = GetIt.instance;

  //Blocs
  inj.registerFactory<SetOweRecordAmountStepBloc>(
    () => SetOweRecordAmountStepBloc(),
  );
  inj.registerFactory<SetOweRecordDescriptionStepBloc>(
    () => SetOweRecordDescriptionStepBloc(
      addFavoriteDescription: inj(),
      loadDebtorFavoriteDebts: inj(),
      loadDebtorFavoriteCredits: inj(),
    ),
  );
  inj.registerFactory<SetOweRecordInfoReviewBloc>(
    () => SetOweRecordInfoReviewBloc(
      addMonetaryRecordAndUpdateDebtor: inj(),
      editMonetaryRecordAndUpdateDebtor: inj(),
    ),
  );

  //Use Cases

  //Repositories

  //Data Sources
}

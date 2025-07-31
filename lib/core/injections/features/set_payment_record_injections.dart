import 'package:get_it/get_it.dart';
import 'package:owe_me/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';

void initSetPaymentRecordInjections() {
  final inj = GetIt.instance;

  //Blocs
  inj.registerFactory<SetPaymentRecordInfoReviewBloc>(
    () => SetPaymentRecordInfoReviewBloc(addMonetaryRecord: inj()),
  );

  //Use Cases

  //Repositories

  //Data Sources
}

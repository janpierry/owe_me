import 'package:owe_me/src/app/di/features/core_injections.dart';
import 'package:owe_me/src/app/di/features/debtor_injections.dart';
import 'package:owe_me/src/app/di/features/favorite_description_injection.dart';
import 'package:owe_me/src/app/di/features/monetary_record_injections.dart';
import 'package:owe_me/src/app/di/features/validation_injections.dart';

Future<void> init() async {
  initCoreInjections();
  initDebtorInjections();
  initFavoriteDescriptionInjections();
  initMonetaryRecordInjections();
  initValidationInjections();
}

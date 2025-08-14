import 'package:owe_me/src/app/di/features/core_injections.dart';
import 'package:owe_me/src/app/di/features/debtors_injections.dart';
import 'package:owe_me/src/app/di/features/favorite_description_injection.dart';
import 'package:owe_me/src/app/di/features/monetary_record_injections.dart';
import 'package:owe_me/src/app/di/features/owe_record_injections.dart';
import 'package:owe_me/src/app/di/features/payment_record_injections.dart';
import 'package:owe_me/src/app/di/features/set_owe_record_injections.dart';
import 'package:owe_me/src/app/di/features/set_payment_record_injections.dart';

//TODO organize injections
Future<void> init() async {
  initCoreInjections();
  initDebtorsInjections();
  initFavoriteDescriptionInjections();
  initMonetaryRecordInjections();
  initOweRecordInjections();
  initPaymentRecordInjections();
  initSetOweRecordInjections();
  initSetPaymentRecordInjections();
}

import 'package:owe_me/src/owe_me/di/features/core_injections.dart';
import 'package:owe_me/src/owe_me/di/features/debtors_injections.dart';
import 'package:owe_me/src/owe_me/di/features/favorite_description_injection.dart';
import 'package:owe_me/src/owe_me/di/features/monetary_record_injections.dart';
import 'package:owe_me/src/owe_me/di/features/owe_record_injections.dart';
import 'package:owe_me/src/owe_me/di/features/payment_record_injections.dart';
import 'package:owe_me/src/owe_me/di/features/set_owe_record_injections.dart';
import 'package:owe_me/src/owe_me/di/features/set_payment_record_injections.dart';

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

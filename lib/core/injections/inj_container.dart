import 'package:owe_me/core/injections/features/core_injections.dart';
import 'package:owe_me/core/injections/features/debtors_injections.dart';
import 'package:owe_me/core/injections/features/favorite_description_injection.dart';
import 'package:owe_me/core/injections/features/monetary_record_injections.dart';
import 'package:owe_me/core/injections/features/owe_record_injections.dart';
import 'package:owe_me/core/injections/features/payment_record_injections.dart';
import 'package:owe_me/core/injections/features/set_owe_record_injections.dart';
import 'package:owe_me/core/injections/features/set_payment_record_injections.dart';

//TODO organize injections better, maybe by pages
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

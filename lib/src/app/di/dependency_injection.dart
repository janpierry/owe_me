import 'package:owe_me/src/owe_me/di/features/core_injections.dart';
import 'package:owe_me/src/owe_me/di/features/debtor_injections.dart';
import 'package:owe_me/src/owe_me/di/features/favorite_description_injection.dart';
import 'package:owe_me/src/owe_me/di/features/monetary_record_injections.dart';

Future<void> init() async {
  initCoreInjections();
  initDebtorInjections();
  initFavoriteDescriptionInjections();
  initMonetaryRecordInjections();
}

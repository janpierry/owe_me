import 'package:get_it/get_it.dart';
import 'package:owe_me/src/domain/validation/validators/amount_validator.dart';

void initValidationInjections() {
  final inj = GetIt.instance;

  // Validators
  inj.registerLazySingleton<AmountValidator>(() => AmountValidator());
}

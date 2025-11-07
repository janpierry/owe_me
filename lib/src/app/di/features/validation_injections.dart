import 'package:get_it/get_it.dart';
import 'package:owe_me/src/domain/validation/validators/amount_validator.dart';
import 'package:owe_me/src/presentation/validation/mappers/amount_validation_mapper.dart';
import 'package:owe_me/src/presentation/validation/services/validation_service.dart';
import 'package:owe_me/src/presentation/validation/services/validation_services.dart';

void initValidationInjections() {
  final inj = GetIt.instance;

  // Validators
  inj.registerLazySingleton<AmountValidator>(() => AmountValidator());

  // Mappers
  inj.registerLazySingleton<AmountValidationMapper>(() => AmountValidationMapper());

  // Services
  inj.registerLazySingleton<AmountValidationService>(
    () => ValidationService(
      validator: inj<AmountValidator>(),
      mapper: inj<AmountValidationMapper>(),
    ),
  );
}

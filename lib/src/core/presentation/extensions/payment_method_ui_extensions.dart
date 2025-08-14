import 'package:owe_me/src/domain/enums/payment_method.dart';

extension PaymentMethodUi on PaymentMethod {
  String get label => switch (this) {
        PaymentMethod.cash => 'Dinheiro',
        PaymentMethod.pix => 'Pix',
      };
}

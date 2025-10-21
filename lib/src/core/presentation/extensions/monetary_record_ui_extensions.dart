import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/extensions/owe_type_ui_extensions.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';

extension MonetaryRecordUi on MonetaryRecord {
  String get typeLabel => switch (this) {
        PaymentRecord() => 'pagamento',
        OweRecord(:final oweType) => oweType.label,
      };

  IconData get iconData => switch (this) {
        PaymentRecord() => Icons.payment,
        OweRecord(:final oweType) => oweType.iconData
      };
}

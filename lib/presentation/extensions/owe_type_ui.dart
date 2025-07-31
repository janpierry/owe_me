import 'package:flutter/material.dart';
import 'package:owe_me/domain/enums/owe_type.dart';

extension OweTypeUi on OweType {
  String get label => switch (this) {
        OweType.debt => 'debt',
        OweType.credit => 'credit',
      };

  String get labelPlural => '${label}s';

  IconData get iconData => switch (this) {
        OweType.debt => Icons.attach_money,
        OweType.credit => Icons.money_off_csred,
      };
}

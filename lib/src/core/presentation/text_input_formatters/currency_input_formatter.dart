import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  int _numericValue = 0;

  String formatNumber(int valueInCents) {
    //TODO adapt this to the user's locale
    final ptBRFormatter = NumberFormat.currency(
      locale: "pt_BR",
      symbol: "R\$",
      decimalDigits: 2,
    );
    // final enUSFormatter = NumberFormat.currency(
    //   locale: "en_US",
    //   symbol: "\$",
    //   decimalDigits: 2,
    // );
    return ptBRFormatter.format(valueInCents / 100).trim();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    _numericValue = int.tryParse(newText) ?? 0;

    final formatted = formatNumber(_numericValue);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

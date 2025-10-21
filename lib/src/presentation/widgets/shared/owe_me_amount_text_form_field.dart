import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/utils/money_utils.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';
import 'package:owe_me/src/core/presentation/text_input_formatters/currency_input_formatter.dart';

class OweMeAmountTextFormField extends StatefulWidget {
  final Money? initialAmount;
  final ValueChanged<Money>? onAmountChanged;
  final bool autoFocus;

  const OweMeAmountTextFormField({
    super.key,
    this.initialAmount,
    this.onAmountChanged,
    this.autoFocus = false,
  });

  @override
  State<OweMeAmountTextFormField> createState() => _OweMeAmountTextFormFieldState();
}

class _OweMeAmountTextFormFieldState extends State<OweMeAmountTextFormField> {
  final _controller = TextEditingController();
  final _formatter = CurrencyInputFormatter();

  @override
  void initState() {
    super.initState();

    _controller.text = _formatter.formatNumber(widget.initialAmount?.cents ?? 0);
    _controller.addListener(() {
      final amount = MoneyUtils.fromStringCurrency(_controller.text);
      widget.onAmountChanged?.call(amount);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        filled: true,
        fillColor: OweMeColors.surfaceWhite,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: OweMeColors.borderGray,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: OweMeColors.primaryBlue,
            width: 1,
          ),
        ),
      ),
      style: OweMeTextStyles.body,
      controller: _controller,
      inputFormatters: [_formatter],
      keyboardType: TextInputType.number,
      autofocus: widget.autoFocus,
    );
  }
}

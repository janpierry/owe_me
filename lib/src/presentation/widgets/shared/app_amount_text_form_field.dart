import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/utils/money_utils.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/core/presentation/text_input_formatters/currency_input_formatter.dart';

class AppAmountTextFormField extends StatefulWidget {
  final Money? initialAmount;
  final ValueChanged<Money>? onAmountChanged;
  final bool autoFocus;

  const AppAmountTextFormField({
    super.key,
    this.initialAmount,
    this.onAmountChanged,
    this.autoFocus = false,
  });

  @override
  State<AppAmountTextFormField> createState() => _AppAmountTextFormFieldState();
}

class _AppAmountTextFormFieldState extends State<AppAmountTextFormField> {
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
        fillColor: AppColors.surfaceWhite,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.borderGray,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryBlue,
            width: 1,
          ),
        ),
      ),
      style: AppTextStyles.body,
      controller: _controller,
      inputFormatters: [_formatter],
      keyboardType: TextInputType.number,
      autofocus: widget.autoFocus,
    );
  }
}

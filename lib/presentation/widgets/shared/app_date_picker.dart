import 'package:flutter/material.dart';
import 'package:owe_me/core/utils/app_date_utils.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';

class AppDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateChanged;

  const AppDatePicker({
    super.key,
    this.initialDate,
    this.onDateChanged,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final initialDate = widget.initialDate;
    if (initialDate != null) {
      _selectedDate = initialDate;
      _dateController.text = AppDateUtils.getFormattedDate(initialDate);
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        String formattedDate = AppDateUtils.getFormattedDate(selectedDate);
        _dateController.text = formattedDate;
        _selectedDate = selectedDate;
      });

      widget.onDateChanged?.call(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        hintText: 'Select a date',
        contentPadding: const EdgeInsets.all(12),
        filled: true,
        fillColor: AppColors.surfaceWhite,
        suffixIcon: const Icon(
          Icons.calendar_today,
          size: 20,
          color: AppColors.textGray,
        ),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/utils/owe_me_date_utils.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';

class OweMeDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateChanged;

  const OweMeDatePicker({
    super.key,
    this.initialDate,
    this.onDateChanged,
  });

  @override
  State<OweMeDatePicker> createState() => _OweMeDatePickerState();
}

class _OweMeDatePickerState extends State<OweMeDatePicker> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final initialDate = widget.initialDate;
    if (initialDate != null) {
      _selectedDate = initialDate;
      _dateController.text = OweMeDateUtils.getFormattedDate(initialDate);
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
        String formattedDate = OweMeDateUtils.getFormattedDate(selectedDate);
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
        fillColor: OweMeColors.surfaceWhite,
        suffixIcon: const Icon(
          Icons.calendar_today,
          size: 20,
          color: OweMeColors.textGray,
        ),
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
    );
  }
}

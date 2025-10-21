import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';

class OweMeDropdown<T> extends StatelessWidget {
  final String? hintText;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?>? onChanged;
  final String Function(T) itemLabelBuilder;

  const OweMeDropdown({
    super.key,
    this.hintText,
    required this.items,
    required this.itemLabelBuilder,
    this.selectedItem,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: selectedItem,
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabelBuilder(item)),
            ),
          )
          .toList(),
      onChanged: onChanged,
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 24,
        color: OweMeColors.textGray,
      ),
      decoration: InputDecoration(
        hintText: hintText,
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
    );
  }
}

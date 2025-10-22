import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';

class OweMeAppBar extends AppBar {
  final String titleText;
  final Color? titleColor;

  OweMeAppBar({
    super.key,
    required this.titleText,
    this.titleColor,
    super.actions,
  }) : super(
          title: Text(
            titleText,
            style: OweMeTextStyles.headline1.copyWith(
              color: titleColor ?? OweMeTextStyles.headline1.color,
            ),
          ),
          centerTitle: true,
          backgroundColor: OweMeColors.surfaceWhite,
          elevation: 1,
        );
}

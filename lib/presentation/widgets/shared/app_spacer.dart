import 'package:flutter/material.dart';

class AppSpacer extends StatelessWidget {
  final double? minWidth;
  final double? minHeight;

  const AppSpacer({super.key, this.minWidth, this.minHeight});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: minWidth,
        height: minHeight,
      ),
    );
  }
}

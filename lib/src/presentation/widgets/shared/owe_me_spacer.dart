import 'package:flutter/material.dart';

class OweMeSpacer extends StatelessWidget {
  final double? minWidth;
  final double? minHeight;

  const OweMeSpacer({super.key, this.minWidth, this.minHeight});

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

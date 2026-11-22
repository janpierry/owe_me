import 'package:flutter/widgets.dart';

/// The strip at the bottom of a page that holds its primary action, kept clear
/// of the system's bottom inset (the iPhone home indicator, Android's gesture
/// bar).
///
/// Place it last in the [Column] of a `Scaffold` body. With the keyboard open
/// the `Scaffold` lifts the body above it and the platform drops the bottom
/// padding to 0, so the action sits right on top of the keyboard with no extra
/// gap.
class OweMeBottomActionArea extends StatelessWidget {
  final Widget child;

  const OweMeBottomActionArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}

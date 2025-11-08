import 'package:flutter/widgets.dart';
import 'package:owe_me/src/presentation/validation/mappers/amount_validation_mapper.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AmountValidationMapper()),
      ],
      child: child,
    );
  }
}

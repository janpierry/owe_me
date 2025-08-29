import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/amount_step/set_owe_record_amount_step_bloc.dart';
import 'package:owe_me/src/core/presentation/extensions/owe_type_ui_extensions.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/amount_step_page/set_owe_record_amount_step_primary_button.dart';
import 'package:owe_me/src/presentation/widgets/shared/app_amount_text_form_field.dart';

class SetOweRecordAmountStepBody extends StatelessWidget {
  final Debtor recordDebtor;
  final OweType oweRecordType;
  final Money amountToEdit;

  const SetOweRecordAmountStepBody({
    super.key,
    required this.recordDebtor,
    required this.oweRecordType,
    required this.amountToEdit,
  });

  void _onAmountChanged(Money amount, BuildContext context) {
    context.read<SetOweRecordAmountStepBloc>().add(
          SetOweRecordAmountStepAmountChanged(amount: amount),
        );
  }

  String get _stepTitle =>
      'Qual o valor do novo ${oweRecordType.label} que ${recordDebtor.nickname} tem com você?';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_stepTitle, style: AppTextStyles.subtitle),
                const SizedBox(height: 8),
                AppAmountTextFormField(
                  initialAmount: amountToEdit,
                  onAmountChanged: (money) => _onAmountChanged(money, context),
                  autoFocus: true,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SetOweRecordAmountStepPrimaryButton(),
        ),
      ],
    );
  }
}

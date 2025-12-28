import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/amount_step/set_owe_record_amount_step_bloc.dart';
import 'package:owe_me/src/core/presentation/extensions/owe_type_ui_extensions.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';
import 'package:owe_me/src/presentation/validation_mappers/amount_validation_mapper.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/amount_step_page/set_owe_record_amount_step_primary_button.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_amount_text_form_field.dart';

class SetOweRecordAmountStepBody extends StatelessWidget {
  final Debtor recordDebtor;
  final OweType oweRecordType;
  final bool isReviewing;

  const SetOweRecordAmountStepBody({
    super.key,
    required this.recordDebtor,
    required this.oweRecordType,
    required this.isReviewing,
  });

  void _onAmountChanged(Money amount, BuildContext context) {
    context.read<SetOweRecordAmountStepBloc>().add(
          SetOweRecordAmountStepAmountChanged(amount: amount),
        );
  }

  String get _stepTitle =>
      'Qual o valor deste ${oweRecordType.label} que ${recordDebtor.nickname} tem com você?';

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
                Text(_stepTitle, style: OweMeTextStyles.subtitle),
                const SizedBox(height: 8),
                BlocBuilder<SetOweRecordAmountStepBloc, SetOweRecordAmountStepState>(
                  builder: (context, state) {
                    return OweMeAmountTextFormField(
                      initialAmount: state.amount.value,
                      onAmountChanged: (money) => _onAmountChanged(money, context),
                      errorText:
                          state.amount.showError ? state.amount.failure?.uiMessage : null,
                      autoFocus: true,
                    );
                  },
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<SetOweRecordAmountStepBloc, SetOweRecordAmountStepState>(
            builder: (context, state) {
              return SetOweRecordAmountStepPrimaryButton(
                isEnabled: state.isValid,
                isReviewing: isReviewing,
              );
            },
          ),
        ),
      ],
    );
  }
}

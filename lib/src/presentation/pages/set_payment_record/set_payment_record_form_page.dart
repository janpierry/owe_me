import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/form/set_payment_record_form_bloc.dart';
import 'package:owe_me/src/presentation/containers/set_payment_record/set_payment_record_info_review_container.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/core/presentation/extensions/payment_method_ui_extensions.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';
import 'package:owe_me/src/presentation/models/enums/form_status.dart';
import 'package:owe_me/src/presentation/widgets/set_payment_record/form/set_payment_record_form_primary_button.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_amount_text_form_field.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_app_bar.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_date_picker.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_dropdown.dart';

class SetPaymentRecordFormPage extends StatelessWidget {
  final PaymentRecord? paymentRecordToEdit;
  final PaymentRecordDraft? paymentRecordDraftToReview;
  final Debtor recordDebtor;
  final bool fromDebtorPage;

  const SetPaymentRecordFormPage({
    super.key,
    this.paymentRecordToEdit,
    this.paymentRecordDraftToReview,
    required this.recordDebtor,
    required this.fromDebtorPage,
  });

  void _listen(BuildContext context, SetPaymentRecordFormState state) {
    if (state.status == FormStatus.success) {
      _navigateToNextPage(context, state);
    }
    if (state.status == FormStatus.error) {
      _showErrorSnackBar(context);
    }
  }

  void _navigateToNextPage(BuildContext context, SetPaymentRecordFormState state) {
    if (_isReviewing) {
      _finishInfoReview(context, state.paymentRecordDraft);
    } else {
      _navigateToInfoReviewPage(context, state.paymentRecordDraft);
    }
  }

  void _finishInfoReview(BuildContext context, PaymentRecordDraft paymentRecordDraft) {
    _popCurrentPageAndPreviousInfoReviewPage(context);
    _navigateToInfoReviewPage(context, paymentRecordDraft);
  }

  void _popCurrentPageAndPreviousInfoReviewPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _navigateToInfoReviewPage(
    BuildContext context,
    PaymentRecordDraft paymentRecordDraft,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetPaymentRecordInfoReviewContainer(
          paymentRecordDraft: paymentRecordDraft,
          recordDebtor: recordDebtor,
          paymentRecordToEdit: paymentRecordToEdit,
          fromDebtorPage: fromDebtorPage,
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Confira as informações.'),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  bool get _isReviewing => paymentRecordDraftToReview != null;

  bool get _isEditing => paymentRecordToEdit != null;

  String get _pageTitle => _isEditing ? 'Editar Pagamento' : 'Novo Pagamento';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OweMeAppBar(
        titleText: _pageTitle,
      ),
      backgroundColor: OweMeColors.backgroundLight,
      body: BlocListener<SetPaymentRecordFormBloc, SetPaymentRecordFormState>(
        listener: _listen,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Qual foi o valor do pagamento?',
                      style: OweMeTextStyles.subtitle,
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<SetPaymentRecordFormBloc, SetPaymentRecordFormState>(
                      builder: (context, state) {
                        return OweMeAmountTextFormField(
                          initialAmount: state.paymentRecordDraft.amount,
                          onAmountChanged: (amount) {
                            context
                                .read<SetPaymentRecordFormBloc>()
                                .add(SetPaymentRecordFormAmountChanged(amount: amount));
                          },
                          errorText: state.amountErrorMessage,
                          autoFocus: true,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Qual foi o método de pagamento?',
                      style: OweMeTextStyles.subtitle,
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<SetPaymentRecordFormBloc, SetPaymentRecordFormState>(
                      builder: (context, state) {
                        return OweMeDropdown<PaymentMethod>(
                          hintText: 'Selecione o método de pagamento',
                          items: PaymentMethod.values,
                          itemLabelBuilder: (paymentMethod) => paymentMethod.label,
                          selectedItem: state.paymentRecordDraft.paymentMethod,
                          onChanged: (paymentMethod) {
                            context.read<SetPaymentRecordFormBloc>().add(
                                  SetPaymentRecordFormPaymentMethodChanged(
                                    paymentMethod: paymentMethod,
                                  ),
                                );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Qual foi a data deste pagamento?',
                      style: OweMeTextStyles.subtitle,
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<SetPaymentRecordFormBloc, SetPaymentRecordFormState>(
                      builder: (context, state) {
                        return OweMeDatePicker(
                          initialDate: state.paymentRecordDraft.date,
                          onDateChanged: (date) {
                            context
                                .read<SetPaymentRecordFormBloc>()
                                .add(SetPaymentRecordFormDateChanged(date: date));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<SetPaymentRecordFormBloc, SetPaymentRecordFormState>(
                builder: (context, state) {
                  return SetPaymentRecordFormPrimaryButton(
                    isEnabled: state.isValid,
                    isReviewing: _isReviewing,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

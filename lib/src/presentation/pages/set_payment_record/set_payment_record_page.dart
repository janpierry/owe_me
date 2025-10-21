import 'package:flutter/material.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/core/presentation/extensions/payment_method_ui_extensions.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_payment_record/page/set_payment_record_primary_button.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_amount_text_form_field.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_date_picker.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_dropdown.dart';

class SetPaymentRecordPage extends StatefulWidget {
  final PaymentRecord? paymentRecordToEdit;
  final PaymentRecordDraft? paymentRecordDraftToReview;
  final Debtor recordDebtor;
  final bool fromDebtorPage;

  const SetPaymentRecordPage({
    super.key,
    this.paymentRecordToEdit,
    this.paymentRecordDraftToReview,
    required this.recordDebtor,
    required this.fromDebtorPage,
  });

  @override
  State<SetPaymentRecordPage> createState() => _SetPaymentRecordPageState();
}

class _SetPaymentRecordPageState extends State<SetPaymentRecordPage> {
  late PaymentRecordDraft _paymentRecordDraft;

  @override
  void initState() {
    super.initState();
    _paymentRecordDraft = widget.paymentRecordDraftToReview ??
        PaymentRecordDraft(
          amount: widget.paymentRecordToEdit?.amount ?? Money.zero(),
          paymentMethod: widget.paymentRecordToEdit?.paymentMethod ?? PaymentMethod.cash,
          date: widget.paymentRecordToEdit?.date ?? DateTime.now(),
        );
  }

  void _onAmountChanged(Money amount) {
    setState(() {
      _paymentRecordDraft = _paymentRecordDraft.copyWith(amount: amount);
    });
  }

  void _onPaymentMethodChanged(PaymentMethod? paymentMethod) {
    setState(() {
      _paymentRecordDraft = _paymentRecordDraft.copyWith(paymentMethod: paymentMethod);
    });
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _paymentRecordDraft = _paymentRecordDraft.copyWith(date: date);
    });
  }

  bool get _isReviewing => widget.paymentRecordDraftToReview != null;

  bool get _isEditing => widget.paymentRecordToEdit != null;

  String get _pageTitle => _isEditing ? 'Editar Pagamento' : 'Novo Pagamento';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle, style: OweMeTextStyles.headline1),
        backgroundColor: OweMeColors.surfaceWhite,
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: OweMeColors.backgroundLight,
      body: Column(
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
                  SizedBox(height: 8),
                  OweMeAmountTextFormField(
                    initialAmount: _paymentRecordDraft.amount,
                    onAmountChanged: _onAmountChanged,
                    autoFocus: true,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Qual foi o método de pagamento?',
                    style: OweMeTextStyles.subtitle,
                  ),
                  const SizedBox(height: 8),
                  OweMeDropdown<PaymentMethod>(
                    hintText: 'Selecione o método de pagamento',
                    items: PaymentMethod.values,
                    itemLabelBuilder: (paymentMethod) => paymentMethod.label,
                    selectedItem: _paymentRecordDraft.paymentMethod,
                    onChanged: _onPaymentMethodChanged,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Qual foi a data deste pagamento?',
                    style: OweMeTextStyles.subtitle,
                  ),
                  const SizedBox(height: 8),
                  OweMeDatePicker(
                    initialDate: _paymentRecordDraft.date ?? DateTime.now(),
                    onDateChanged: _onDateChanged,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SetPaymentRecordPrimaryButton(
              paymentRecordDraft: _paymentRecordDraft,
              recordDebtor: widget.recordDebtor,
              paymentRecordToEdit: widget.paymentRecordToEdit,
              isReviewing: _isReviewing,
              fromDebtorPage: widget.fromDebtorPage,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/core/presentation/extensions/owe_type_ui_extensions.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/owe_me_text_styles.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/date_step_page/set_owe_record_date_step_primary_button.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_date_picker.dart';

class SetOweRecordDateStepPage extends StatefulWidget {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;
  final OweRecord? oweRecordToEdit;
  final bool isReviewing;
  final bool fromDebtorPage;

  const SetOweRecordDateStepPage({
    super.key,
    required this.oweRecordDraft,
    required this.recordDebtor,
    required this.oweRecordToEdit,
    required this.isReviewing,
    required this.fromDebtorPage,
  });

  @override
  State<SetOweRecordDateStepPage> createState() => _SetOweRecordDateStepPageState();
}

class _SetOweRecordDateStepPageState extends State<SetOweRecordDateStepPage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate =
        widget.oweRecordDraft.date ?? widget.oweRecordToEdit?.date ?? DateTime.now();
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  String get _stepTitle =>
      'Qual foi a data deste ${widget.oweRecordDraft.oweType.label}?';

  OweRecordDraft get _updatedOweRecordDraft =>
      widget.oweRecordDraft.copyWith(date: _selectedDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informe a Data',
          style: OweMeTextStyles.headline1,
        ),
        backgroundColor: OweMeColors.surfaceWhite,
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_stepTitle, style: OweMeTextStyles.subtitle),
                  const SizedBox(height: 8),
                  OweMeDatePicker(
                    initialDate: widget.oweRecordDraft.date ?? DateTime.now(),
                    onDateChanged: _onDateChanged,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SetOweRecordDateStepPrimaryButton(
              oweRecordDraft: _updatedOweRecordDraft,
              recordDebtor: widget.recordDebtor,
              oweRecordToEdit: widget.oweRecordToEdit,
              isReviewing: widget.isReviewing,
              fromDebtorPage: widget.fromDebtorPage,
            ),
          ),
        ],
      ),
    );
  }
}

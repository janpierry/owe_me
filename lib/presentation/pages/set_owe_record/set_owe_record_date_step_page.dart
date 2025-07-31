import 'package:flutter/material.dart';
import 'package:owe_me/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/presentation/extensions/owe_type_ui.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';
import 'package:owe_me/presentation/widgets/set_owe_record/date_step_page/set_owe_record_date_step_primary_button.dart';
import 'package:owe_me/presentation/widgets/shared/app_date_picker.dart';

class SetOweRecordDateStepPage extends StatefulWidget {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;

  const SetOweRecordDateStepPage({
    super.key,
    required this.oweRecordDraft,
    required this.recordDebtor,
  });

  @override
  State<SetOweRecordDateStepPage> createState() => _SetOweRecordDateStepPageState();
}

class _SetOweRecordDateStepPageState extends State<SetOweRecordDateStepPage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.oweRecordDraft.date ?? DateTime.now();
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

  bool get _isEdition => widget.oweRecordDraft.date != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_stepTitle, style: AppTextStyles.subtitle),
                  const SizedBox(height: 8),
                  AppDatePicker(
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
              isEdition: _isEdition,
            ),
          ),
        ],
      ),
    );
  }
}

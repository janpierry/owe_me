import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';

class SetOweRecordDescriptionTextFormField extends StatefulWidget {
  final String initialDescription;

  const SetOweRecordDescriptionTextFormField({
    super.key,
    required this.initialDescription,
  });

  @override
  State<SetOweRecordDescriptionTextFormField> createState() =>
      _SetOweRecordDescriptionTextFormFieldState();
}

class _SetOweRecordDescriptionTextFormFieldState
    extends State<SetOweRecordDescriptionTextFormField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.text = widget.initialDescription;
    _controller.addListener(
      () => context.read<SetOweRecordDescriptionStepBloc>().add(
            SetOweRecordDescriptionStepDescriptionChangedEvent(
              description: _controller.text,
            ),
          ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _listen(BuildContext context, SetOweRecordDescriptionStepState state) {
    if (state is SetOweRecordDescriptionStepSendingDescriptionToTextField) {
      _controller.text = state.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetOweRecordDescriptionStepBloc,
        SetOweRecordDescriptionStepState>(
      listener: _listen,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Descrição não informada',
          hintStyle: AppTextStyles.body.copyWith(
            color: AppColors.textGray,
          ),
          contentPadding: const EdgeInsets.all(12),
          filled: true,
          fillColor: AppColors.surfaceWhite,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.borderGray,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.primaryBlue,
              width: 1,
            ),
          ),
        ),
        style: AppTextStyles.body,
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.text,
      ),
    );
  }
}

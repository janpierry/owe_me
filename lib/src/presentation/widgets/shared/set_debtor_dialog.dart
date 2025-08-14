import 'package:flutter/material.dart';
import 'package:owe_me/src/core/presentation/callbacks.dart';
import 'package:owe_me/src/core/presentation/design_system/app_colors.dart';
import 'package:owe_me/src/core/presentation/design_system/app_text_styles.dart';

class SetDebtorDialog extends StatefulWidget {
  final String? initialNickname;
  final SetDebtorPressedCallback? onSetDebtorPressed;

  const SetDebtorDialog({
    super.key,
    this.initialNickname,
    this.onSetDebtorPressed,
  });

  @override
  State<SetDebtorDialog> createState() => _SetDebtorDialogState();
}

class _SetDebtorDialogState extends State<SetDebtorDialog> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _isButtonEnabled = false;

  String? _errorText;

  bool get _isEditing => widget.initialNickname != null;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initialNickname ?? '');
    _isButtonEnabled = _controller.text.trim().isNotEmpty;

    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (hasText != _isButtonEnabled) {
        setState(() {
          _isButtonEnabled = hasText;
          _errorText = null;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    final nickname = _controller.text.trim();
    if (nickname.isEmpty) {
      setState(() {
        _errorText = 'Apelido é obrigatório';
      });
    } else {
      widget.onSetDebtorPressed?.call(nickname);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: AppColors.surfaceWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 312,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            //TODO create file for shadows
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _isEditing ? 'Editar Devedor' : 'Novo Devedor',
              style: AppTextStyles.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Apelido', style: AppTextStyles.body),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: "Insira um apelido para o devedor",
                    hintStyle: AppTextStyles.body.copyWith(
                      color: AppColors.textGray,
                    ),
                    filled: true,
                    //TODO test this
                    fillColor: AppColors.surfaceWhite,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
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
                ),
                if (_errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      _errorText!,
                      style: AppTextStyles.body.copyWith(color: AppColors.red),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'Cancelar',
                    style: AppTextStyles.subtitle.copyWith(color: AppColors.textGray),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isButtonEnabled ? _validateAndSubmit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: AppColors.surfaceWhite,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    minimumSize: const Size(0, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isEditing ? 'Editar' : 'Adicionar',
                    style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

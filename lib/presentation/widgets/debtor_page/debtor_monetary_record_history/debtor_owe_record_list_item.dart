import 'package:flutter/material.dart';
import 'package:owe_me/core/utils/date_formatters.dart';
import 'package:owe_me/domain/entities/owe_record.dart';
import 'package:owe_me/presentation/extensions/owe_type_ui_extensions.dart';
import 'package:owe_me/presentation/shared/design_system/app_colors.dart';
import 'package:owe_me/presentation/shared/design_system/app_text_styles.dart';

class DebtorOweRecordListItem extends StatelessWidget {
  final OweRecord oweRecord;

  const DebtorOweRecordListItem({super.key, required this.oweRecord});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      color: AppColors.surfaceWhite,
      child: Container(
        height: 72,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              oweRecord.oweType.iconData,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    oweRecord.description ?? 'Sem descrição',
                    style: AppTextStyles.subtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    DateFormatters.ddMMMyyyy.format(oweRecord.date),
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              oweRecord.amount.toString(),
              style: AppTextStyles.headline2,
            ),
          ],
        ),
      ),
    );
  }
}

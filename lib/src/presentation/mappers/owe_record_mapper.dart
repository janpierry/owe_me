import 'package:owe_me/src/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/owe_record.dart';

class OweRecordMapper {
  const OweRecordMapper._();

  static OweRecord toEntity(OweRecordDraft draft) {
    if (draft.amount == null || draft.amount!.cents <= 0) {
      throw ArgumentError('Invalid amount: ${draft.amount}');
    }
    if (draft.description == null || draft.description!.trim().isEmpty) {
      throw ArgumentError('Invalid description: ${draft.description}');
    }
    if (draft.date == null) {
      throw ArgumentError('Invalid date: ${draft.date}');
    }

    return OweRecord(
      id: null, // ID will be assigned when saved in database
      amount: draft.amount!,
      description: draft.description!,
      date: draft.date!,
      oweType: draft.oweType,
    );
  }
}

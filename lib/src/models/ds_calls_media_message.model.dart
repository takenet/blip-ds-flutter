import '../enums/ds_call_direction.enum.dart';
import '../enums/ds_call_provider.enum.dart';
import '../enums/ds_call_status.enum.dart';
import '../enums/ds_call_type.enum.dart';
import '../extensions/ds_enum.extension.dart';

class DSCallsMediaMessage {
  final String? sessionId;
  final DSCallType? type;
  final DSCallProvider? provider;
  final DSCallDirection? direction;
  final DSCallStatus? status;
  final String? ticketId;
  final String? identification;
  final int? callDuration;

  DSCallsMediaMessage({
    required this.sessionId,
    required this.type,
    required this.provider,
    required this.direction,
    required this.status,
    required this.ticketId,
    required this.identification,
    this.callDuration,
  });

  DSCallsMediaMessage.fromJson(Map<String, dynamic> json)
      : sessionId = json['sessionId'],
        type = DSCallType.values.byNameOrNull(json['type']),
        provider = DSCallProvider.values.byNameOrNull(json['provider']),
        direction = DSCallDirection.values.byNameOrNull(json['direction']),
        status = DSCallStatus.values.byNameOrNull(json['status']),
        ticketId = json['ticketId'],
        identification = json['identification'],
        callDuration = json['callDuration'] ?? 0;
}

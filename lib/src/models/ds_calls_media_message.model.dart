import '../enums/ds_call_direction.enum.dart';
import '../enums/ds_call_provider.enum.dart';
import '../enums/ds_call_status.enum.dart';
import '../enums/ds_call_type.enum.dart';
import '../extensions/ds_enum.extension.dart';

class DSCallsMediaMessage {
  final String sessionId;
  final DSCallType type;
  final DSCallProvider provider;
  final DSCallDirection direction;
  final DSCallStatus status;
  final String ticketId;
  final String identification;
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
        type = DSCallType.values.byNameOrDefault(
          json['type'],
          DSCallType.unknown,
        ),
        provider = DSCallProvider.values.byNameOrDefault(
          json['provider'],
          DSCallProvider.unknown,
        ),
        direction = DSCallDirection.values.byNameOrDefault(
          json['direction'],
          DSCallDirection.unknown,
        ),
        status = DSCallStatus.values.byNameOrDefault(
          json['status'],
          DSCallStatus.unknown,
        ),
        ticketId = json['ticketId'],
        identification = json['identification'],
        callDuration = json['callDuration'] ?? 0;
}

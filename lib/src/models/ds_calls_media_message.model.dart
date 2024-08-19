import '../enums/ds_call_direction.enum.dart';
import '../enums/ds_call_provider.enum.dart';
import '../enums/ds_call_type.enum.dart';

class DSCallsMediaMessage {
  DSCallType? type;
  String sessionId;
  DSCallProvider? provider;
  DSCallDirection direction;
  String? ticketId;
  String status;
  String identification;
  String? media;
  int? callDuration;

  DSCallsMediaMessage({
    this.type,
    required this.sessionId,
    this.provider,
    required this.direction,
    this.ticketId,
    required this.status,
    required this.identification,
    this.media,
    this.callDuration,
  });

  DSCallsMediaMessage.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        sessionId = json['sessionId'],
        provider = json['provider'],
        direction = json['direction'],
        ticketId = json['ticketId'],
        status = json['status'],
        identification = json['identification'],
        media = json['media'],
        callDuration = json['callDuration'];
}

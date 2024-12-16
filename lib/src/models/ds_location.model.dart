import '../extensions/ds_localization.extension.dart';

class DSLocation {
  DSLocation({
    required this.latitude,
    required this.longitude,
    required this.text,
  });

  final double? latitude;
  final double? longitude;
  final String text;

  factory DSLocation.fromJson(Map<String, dynamic> json) {
    return DSLocation(
      latitude: double.tryParse(json['latitude']),
      longitude: double.tryParse(json['longitude']),
      text: (json['text']?.isNotEmpty ?? false)
          ? json['text']
          : 'location.text'.translate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'text': text,
    };
  }
}

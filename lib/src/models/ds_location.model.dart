import '../extensions/ds_localization.extension.dart';

class DSLocation {
  DSLocation({
    required this.text,
    this.latitude,
    this.longitude,
  });

  final double? latitude;
  final double? longitude;
  final String text;

  factory DSLocation.fromJson(Map<String, dynamic> json) {
    return DSLocation(
      latitude: double.tryParse(json['latitude']?.toString() ?? ''),
      longitude: double.tryParse(json['longitude']?.toString() ?? ''),
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

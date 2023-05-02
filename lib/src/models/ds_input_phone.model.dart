import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DSInputPhoneModel {
  final dynamic code;
  final String name;
  final String flag;
  DSInputPhoneModel({
    required this.code,
    required this.name,
    required this.flag,
  });

  @override
  String toString() =>
      'DSInputPhoneModel(code: $code, name: $name, flag: $flag)';

  @override
  bool operator ==(covariant DSInputPhoneModel other) {
    if (identical(this, other)) return true;

    return other.code == code && other.name == name;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode;

  factory DSInputPhoneModel.fromMap(Map<String, dynamic> map) {
    return DSInputPhoneModel(
      code: map['code'] as dynamic,
      name: map['name'] as String,
      flag: map['flag'] as String,
    );
  }

  factory DSInputPhoneModel.fromJson(String source) =>
      DSInputPhoneModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

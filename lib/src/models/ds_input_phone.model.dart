import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DSInputPhoneModel {
  final dynamic code;
  final String name;
  DSInputPhoneModel({
    required this.code,
    required this.name,
  });
  

  @override
  String toString() => 'DSInputPhoneModel(code: $code, name: $name)';

  @override
  bool operator ==(covariant DSInputPhoneModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.code == code &&
      other.name == name;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
    };
  }

  factory DSInputPhoneModel.fromMap(Map<String, dynamic> map) {
    return DSInputPhoneModel(
      code: map['code'] as dynamic,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DSInputPhoneModel.fromJson(String source) => DSInputPhoneModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

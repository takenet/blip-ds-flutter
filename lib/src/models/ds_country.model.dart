import 'dart:convert';

class DSCountry {
  final String code;
  final String name;
  final String flag;

  const DSCountry({
    required this.code,
    required this.name,
    required this.flag,
  });

  DSCountry.fromJson(Map<String, dynamic> map)
      : code = map['code'],
        name = map['name'],
        flag = map['flag'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
      'flag': flag,
    };
  }

  String toJson() => json.encode(toMap());
}

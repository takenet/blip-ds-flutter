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
}

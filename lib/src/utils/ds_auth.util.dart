abstract class DSAuth {
  static String? userAccessToken;

  static Map<String, String> get httpHeaders {
    assert(userAccessToken?.isNotEmpty ?? false,
        'The DSAuth.userAccessToken must have a value.');

    return {
      'Authorization': 'Key $userAccessToken',
    };
  }
}

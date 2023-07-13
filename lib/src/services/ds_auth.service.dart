abstract class DSAuthService {
  static String? _token;
  static String? get token => _token;

  static void init({
    required final String userAccessToken,
  }) {
    assert(userAccessToken.isNotEmpty, 'The token must not be empty.');
    assert(_token != null, 'The DSAuthService was already initialized.');

    _token = userAccessToken;
  }

  static void dispose() {
    _token = null;
  }

  static Map<String, String> get httpHeaders {
    assert(
      token?.isNotEmpty ?? false,
      'The DSAuthService must be initialized.',
    );

    return {
      'Authorization': 'Key $token',
    };
  }
}

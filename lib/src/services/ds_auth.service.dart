abstract class DSAuthService {
  static String? _token;
  static String? get token => _token;
  static String? _googleKey;
  static String? get googleKey => _googleKey;

  static void setUser({
    required final String accessToken,
  }) {
    _token = accessToken;
  }

  static void clearUser() {
    _token = null;
  }

  static void setGoogleApiKey({required final String googleApiKey}) =>
      _googleKey = googleApiKey;

  static Map<String, String> get httpHeaders => token?.isNotEmpty ?? false
      ? {
          'Authorization': 'Key $token',
        }
      : const {};
}

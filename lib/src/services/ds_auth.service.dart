abstract class DSAuthService {
  static String? _token;
  static String? get token => _token;

  static void setUser({
    required final String accessToken,
  }) {
    _token = accessToken;
  }

  static void clearUser() {
    _token = null;
  }

  static Map<String, String> get httpHeaders => token?.isNotEmpty ?? false
      ? {
          'Authorization': 'Key $token',
        }
      : const {};
}

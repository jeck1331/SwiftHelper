class AuthResponse {
  const AuthResponse(
      {
      required this.refreshToken,
      required this.accessToken
      });

  final String accessToken;
  final String refreshToken;
}

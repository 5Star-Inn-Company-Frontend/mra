class AuthError {
  final String message;

  AuthError(this.message);

  @override
  String toString() => message;
}

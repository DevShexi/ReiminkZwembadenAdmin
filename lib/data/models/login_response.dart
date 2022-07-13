enum LoginState {
  userNotFound,
  wrongPassword,
  success,
  notLoggedIn,
}

class LoginResponse {
  LoginResponse({required this.loginState});
  LoginState loginState;
}

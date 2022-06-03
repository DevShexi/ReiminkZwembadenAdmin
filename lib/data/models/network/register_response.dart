enum RegisterationState {
  registerationError,
  successful,
  weakPassword,
  emailAlreadyExists,
  unregistered
}

class RegisterResponse {
  const RegisterResponse({required this.registerationState});
  final RegisterationState registerationState;
}

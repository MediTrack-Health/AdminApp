abstract class LoginEvent {}

class CheckMobileEvent extends LoginEvent {
  final String mobile;
  CheckMobileEvent(this.mobile);
}

class SendOtpEvent extends LoginEvent {
  final String mobile;
  SendOtpEvent(this.mobile);
}

class SubmitLogin extends LoginEvent {
  final String email;
  final String password;
  SubmitLogin({required this.email, required this.password});
}

// login/bloc/login_state.dart

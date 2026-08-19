abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class MobileNotFound extends LoginState {}
class OtpVerified extends LoginState {}
class OtpInvalid extends LoginState {}
class OtpSent extends LoginState {
  final int? userId;
  final String timeStamp;
  OtpSent(this.userId,this.timeStamp);
}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {}

abstract class HospitalSignupState {}

class HospitalSignupInitial extends HospitalSignupState {}

class HospitalSignupLoading extends HospitalSignupState {}

class HospitalSignupSuccess extends HospitalSignupState {
  final String message;

  HospitalSignupSuccess(this.message);
}

class HospitalSignupFailure extends HospitalSignupState {
  final String error;

  HospitalSignupFailure(this.error);
}
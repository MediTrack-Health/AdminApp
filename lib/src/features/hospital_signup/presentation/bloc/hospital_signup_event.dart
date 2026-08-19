import '../../data/models/hospital_signup_request.dart';

abstract class HospitalSignupEvent {}

class SubmitHospitalSignup extends HospitalSignupEvent {
  final HospitalSignupRequest request;

  SubmitHospitalSignup(this.request);
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/logger.dart';
import '../../data/repositories/hospital_signup_repository.dart';
import 'hospital_signup_event.dart';
import 'hospital_signup_state.dart';

class HospitalSignupBloc extends Bloc<HospitalSignupEvent, HospitalSignupState> {
  final HospitalSignupRepository repository;

  HospitalSignupBloc(this.repository) : super(HospitalSignupInitial()) {
    on<SubmitHospitalSignup>((event, emit) async {
      emit(HospitalSignupLoading());
      try {
        logger.d('Submitting hospital signup with request: ${event.request.toJson()}');
        final response = await repository.signupHospital(event.request);
        logger.d('Received hospital signup response: $response');
        emit(HospitalSignupSuccess(response['message']));
      } catch (e) {
        logger.d('HospitalSignupFailure: $e');

        emit(HospitalSignupFailure(e.toString()));
      }
    });
  }
}
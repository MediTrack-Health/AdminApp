import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditrack_admin/src/features/auth/presentation/repo/login_repo.dart';

import '../../../../../widgets/local_storage.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<CheckMobileEvent>((event, emit) async {
      emit(LoginLoading());
      try{
        print('Naresh event ${event.mobile}');

        final exists = await repository.sendOtp(event.mobile);
        print('Naresh exist $exists');

        if (exists.userId!=null) {
          if (exists.success) {
            emit(OtpSent(exists.userId,exists.otpTimestamp));
          } else {
            emit(LoginFailure());
          }
        } else {
          emit(MobileNotFound());
        }
      }catch(_){
        emit(MobileNotFound());
      }
    });

    on<SubmitLogin>((event, emit) async {
      print('Naresh event ${event.email} ${event.password}');
      emit(LoginLoading());
      var data = {
        "email": event.email,
        "password": event.password
      };
      try{
        final success = await repository.logIn(data);
        print('Naresh success  $success ');

        if (success.jwtToken!=null) {
          box.write(StorageVariable.jwtToken, success.jwtToken);
          box.write(StorageVariable.refreshToken, success.refreshToken);
          box.write(StorageVariable.hospitalName, success.hospitalName);
          box.write(StorageVariable.contactPersonName, success.contactPersonName);
          emit(LoginSuccess());
        } else {
          emit(LoginFailure());
        }
      }catch(_){
        emit(LoginFailure());
      }
    });
  }
}

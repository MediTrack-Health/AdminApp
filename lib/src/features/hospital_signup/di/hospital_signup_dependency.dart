import '../../../configs/injector/injector_conf.dart';
import '../data/repositories/hospital_signup_repository.dart';
import '../presentation/bloc/hospital_signup_bloc.dart';

class HospitalSignupDependency {
  HospitalSignupDependency._();

  static void init() {
    getIt.registerLazySingleton(() => HospitalSignupRepository());
    getIt.registerFactory(() => HospitalSignupBloc(getIt<HospitalSignupRepository>()));
  }
}
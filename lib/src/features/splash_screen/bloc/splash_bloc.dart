import 'package:bloc/bloc.dart';
import 'package:meditrack_admin/src/features/splash_screen/bloc/splash_event.dart';
import 'package:meditrack_admin/src/features/splash_screen/bloc/splash_state.dart';
import 'package:meditrack_admin/src/widgets/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(AuthInitial()) {
    on<CheckAuthEvent>((event, emit) async {
      String? refreshToken = box.read(StorageVariable.jwtToken);
      if (refreshToken != null && refreshToken.isNotEmpty) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });
  }
}

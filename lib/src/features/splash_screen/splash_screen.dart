import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditrack_admin/src/features/auth/presentation/pages/auth_page.dart';
import 'package:meditrack_admin/src/features/splash_screen/bloc/splash_bloc.dart';
import 'package:meditrack_admin/src/features/splash_screen/bloc/splash_state.dart';
import 'bloc/splash_event.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(CheckAuthEvent()),
      child: Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => AuthPage()));
            } else if (state is Unauthenticated) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => AuthPage()));
            }
          },
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

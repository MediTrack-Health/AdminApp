import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditrack_admin/src/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:meditrack_admin/src/features/auth/presentation/repo/login_repo.dart';
import 'package:meditrack_admin/src/features/hospital_signup/data/repositories/hospital_signup_repository.dart';
import 'package:meditrack_admin/src/features/hospital_signup/presentation/bloc/hospital_signup_bloc.dart';
import 'package:meditrack_admin/src/features/records/bloc/record_bloc.dart';
import 'package:meditrack_admin/src/features/records/repo/record_repo.dart';
import 'package:toastification/toastification.dart';

import 'configs/injector/injector_conf.dart';
import 'core/blocs/theme/theme_bloc.dart';
import 'core/blocs/translate/translate_bloc.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/relations/bloc/relation_bloc.dart';
import 'features/relations/repo/relation_repo.dart';
import 'features/splash_screen/splash_screen.dart';
import 'routes/app_route_conf.dart';
import 'routes/app_route_path.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouteConf>().router;
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => GestureDetector(
        onTap: () => primaryFocus?.unfocus(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => LoginBloc(LoginRepo()),
            ),
            BlocProvider(
              create: (_) => HospitalSignupBloc(HospitalSignupRepository()),
            ),
            BlocProvider(
              create: (context) => RelationBloc(RelationRepository()),
            ),
            BlocProvider(
              create: (_) => RecordBloc(RecordRepo()),
            ),
            BlocProvider(
              create: (_) => getIt<ThemeBloc>(),
            ),
            BlocProvider(
              create: (_) => getIt<TranslateBloc>(),
            ),
          ],
          child: BlocListener<LoginBloc, LoginState>(
            listenWhen: (_, current) =>
                current is LoginLoading,
            listener: (_, state) {
              if (state is LoginSuccess) {
                /*final user = state.;
                final userMap = {
                  "user_id": user.userId ?? "",
                  "email": user.email ?? "",
                  "username": user.username ?? "",
                };*/

                router.goNamed(
                  AppRoute.home.name,
                  //pathParameters: userMap,
                );
              }
            },
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (_, state) {
                return ToastificationWrapper(
                  child: MaterialApp(
                    home: SplashScreen(),
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    theme:ThemeData(fontFamily: GoogleFonts.inter().fontFamily,
                      scaffoldBackgroundColor: Colors.white,
                    ),
                    darkTheme: ThemeData(
                      useMaterial3: true,
                      brightness: Brightness.light,
                    ),
                    themeMode: ThemeMode.light,
                   // routerConfig: router,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import "package:easy_localization/easy_localization.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get_storage/get_storage.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:hydrated_bloc/hydrated_bloc.dart";
import "package:path_provider/path_provider.dart";

import "src/app.dart";
import "src/configs/adapter/adapter_conf.dart";
import "src/configs/injector/injector_conf.dart";
import "src/core/constants/list_translation_locale.dart";
import "src/core/utils/observer.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
      Brightness.light // Dark == white status bar -- for IOS.
  ));
  await EasyLocalization.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  HydratedBloc.storage = storage;

  await Future.wait([
    // Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // ),
    Hive.initFlutter(),
    // getTemporaryDirectory().then((path) async {
    //   HydratedBloc.storage = await HydratedStorage.build(
    //     storageDirectory: path,
    //   );
    // }),
  ]);

  configureAdapter();

  configureDepedencies();

  Bloc.observer = AppBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: const [indonesiaLocale, englishLocale],
      path: "assets/translations",
      startLocale: englishLocale,
      child: const MyApp(),
    ),
  );
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/theme/app_theme.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/modules/settings_tab/provider/setting_provider.dart';

import 'core/cash_helper/cash_helper.dart';
import 'layout/home_layout.dart';
import 'modules/update_task/update_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CashHelper.init();

  runApp(ChangeNotifierProvider(
      create: (context) => SettingProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<SettingProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: CheekTheme(),

      //pro.currentTheme,
      title: 'To Do App',
      initialRoute: HomeLayout.routeName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(CheekLan()),
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        UpdateTask.routeName: (context) => UpdateTask()
      },
    );
  }

  ThemeMode CheekTheme() {
    if (CashHelper.getData(key: "Theme") != null) {
      if (CashHelper.getData(key: "Theme")) {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    } else {
      return ThemeMode.light;
    }
  }

  String CheekLan() {
    if (CashHelper.getData(key: "lenguge") != null) {
      if (CashHelper.getData(key: "lenguge")) {
        return "ar";
      } else {
        return "en";
      }
    }
    return "en";
  }
}

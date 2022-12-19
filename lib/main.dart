
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vendor/const.dart';
import 'package:vendor/core/view/auth_view.dart';
import 'package:vendor/core/view/notification_view.dart';
import 'package:vendor/core/view/park_view.dart';
import 'package:vendor/firebase_options.dart';
import 'package:vendor/locator.dart';
import 'package:vendor/ui/landing_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setUpLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp(key: Key("asdasd"),),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthView(),
        ),
        ChangeNotifierProvider(
          create: (context) => ParkView(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationView(),
        ),
      ],
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: debugMode,
        theme: ThemeData(
          primarySwatch: primaryColor,
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: "Baloo2",
        ),
        home: const LandingScreen(),
      ),
    );
  }
}

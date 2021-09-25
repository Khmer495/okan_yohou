import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamehub/screens/splash/splash.dart';
import 'package:gamehub/utils/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gamehub/utils/shared_preferences_util.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesUtil.init();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ConstantsColors.white,
        // fontFamily: 'NotoSansJP',
        textTheme: GoogleFonts.notoSansTextTheme(),
      ),
      home: FutureBuilder(
        builder: (context, snapshot) {
          return SplashView();
        },
      ),
    );
  }
}

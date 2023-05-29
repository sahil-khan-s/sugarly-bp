
import 'package:bpcheck/pages/login/auth_service.dart';
import 'package:bpcheck/pages/login/database_service.dart';
import 'package:bpcheck/pages/login/login_screen.dart';
import 'package:bpcheck/pages/patient_screens/blood_pressure/bp_record_screen.dart';
import 'package:bpcheck/pages/patient_screens/patient_dashboard.dart';
import 'package:bpcheck/pages/patient_screens/weight/weight_screen.dart';
import 'package:bpcheck/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<DatabaseService>(
          create: (_) => DatabaseService(),
        ),
      ],
      child: MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
        child: ScreenUtilInit(

          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return  MaterialApp(
              builder: FlutterSmartDialog.init(),
              debugShowCheckedModeBanner: false,
              home: SplashView(),
            );
          },
        ),
      ),
    );
  }
}
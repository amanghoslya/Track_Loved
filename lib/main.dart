import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:track_loved/HomeScreen/DashboardScreen.dart';
import 'package:track_loved/LoginScreen/LoginScreen.dart';
import 'package:track_loved/core/Utils/key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("userdata");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userdata");
    var token = box.get("token");
    log("Bearer Token :- ${token ?? "No Token Found"}");
    return ScreenUtilInit(
      designSize: Size(440, 855),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            // statusBarColor: Color(0xFFF3F3F3),
            // statusBarIconBrightness: Brightness.dark,
            // statusBarBrightness: Brightness.light,
          ),
          child: SafeArea(
            top: false,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              scaffoldMessengerKey: snackBarKey,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              home: token == null ? LoginScreen() : DynamicDashboardScreen(),
            ),
          ),
        );
      },
    );
  }
}

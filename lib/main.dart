import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/screens/lay_out_page.dart';
import 'package:todolist/screens/profile.dart';
import 'firebase_options.dart';

import 'splash_page.dart';
import 'screens/home_page.dart';
import './screens/profile.dart';
import './screens/authgg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          background: Colors.white,
        ),
      ),
      // /  home: AuthScreen()

      //  / ⭐ AUTH WRAPPER (QUAN TRỌNG)
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // ⏳ Đang check đăng nhập
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashPage();
          }

          // ✅ ĐÃ LOGIN
          if (snapshot.hasData) {
            return LayOutPage();
            // hoặc HomePage nếu bạn muốn
          }

          // ❌ CHƯA LOGIN
          return const AuthScreen();
        },
      ),
    );
  }
}

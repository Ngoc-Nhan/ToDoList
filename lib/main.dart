import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/services/task_view_model.dart';

import 'splash_page.dart';
import 'screens/authgg.dart';
import 'screens/lay_out_page.dart';
// import 'screens/add_task_screen.dart'; // nếu đã có

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskViewModel()..fetchTasks(),
      child: const MyApp(),
    ),
  );
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

      // ⭐ AUTH WRAPPER
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashPage();
          }

          if (snapshot.hasData) {
            return const LayOutPage();
          }

          return const AuthScreen();
        },
      ),

      // ⚠️ chỉ bật khi đã làm màn add
      // routes: {
      //   '/add': (_) => const AddTaskScreen(),
      // },
    );
  }
}

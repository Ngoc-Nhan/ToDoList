import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolist/screens/lay_out_page.dart';
import './profile.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? error;
  bool isLogin = true;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  // ===== GOOGLE LOGIN =====
  Future<void> signInWithGoogle() async {
    try {
      // ✅ BẮT BUỘC: logout trước
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LayOutPage()),
        (route) => false,
      );
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  // ===== EMAIL LOGIN / REGISTER =====
  Future<void> submitEmailAuth() async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      }

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => error = e.message);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text("Authentication")),
        body: Center(
          // padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  // height: 100,

                  // width: 100,
                  child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                  ),
                  Text('SmartTasks',
                      style: TextStyle(
                          color: Colors.blue.shade300,
                          fontSize: 25,
                          fontWeight: FontWeight.w500)),
                  Text(
                    'A simple and efficient to-do app',
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )),
              Container(
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text('Ready to explore? Log in to get started'),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade200,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      onPressed: signInWithGoogle,
                      icon: const Icon(Icons.login),
                      label: const Text("Login with Google"),
                    ),
                    if (error != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ]
                  ],
                ),
              ),
              Container(
                height: 100,
              )

              // TextField(
              //   controller: emailController,
              //   decoration: const InputDecoration(labelText: "Email"),
              // ),
              // const SizedBox(height: 12),
              // TextField(
              //   controller: passwordController,
              //   decoration: const InputDecoration(labelText: "Password"),
              //   obscureText: true,
              // ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: submitEmailAuth,
              //   child: Text(isLogin ? "Login with Email" : "Register"),
              // ),
              // TextButton(
              //   onPressed: () => setState(() => isLogin = !isLogin),
              //   child: Text(
              //     isLogin
              //         ? "Chưa có tài khoản? Đăng ký"
              //         : "Đã có tài khoản? Đăng nhập",
              //   ),
              // ),
              // const Divider(height: 32),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Text(
            '©️ UTHSmartTasks',
            textAlign: TextAlign.center,
          ),
        )
        // SizedBox(height: 50,,)
        );
  }
}

import 'package:flutter/material.dart';

/* =======================
   COMMON STYLE
======================= */
const primaryBlue = Color(0xff2196F3);

InputDecoration inputStyle(String hint, IconData icon) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

/* =======================
   SCREEN 1: FORGET PASSWORD
======================= */
class ForgetPwPage extends StatefulWidget {
  const ForgetPwPage({super.key});

  @override
  State<ForgetPwPage> createState() => _ForgetPwPageState();
}

class _ForgetPwPageState extends State<ForgetPwPage> {
  final emailController = TextEditingController();

  Map<String, String>? resultData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset('assets/images/logo.png', width: 100),
              const SizedBox(height: 8),
              const Text(
                "SmartTasks",
                style: TextStyle(color: primaryBlue, fontSize: 20),
              ),
              const SizedBox(height: 40),
              const Text(
                "Forget Password?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter your Email, we will send you a verification code.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: inputStyle("Your Email", Icons.email),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            VerifyCodePage(email: emailController.text),
                      ),
                    );

                    if (result != null && result is Map<String, String>) {
                      setState(() {
                        resultData = result;
                      });
                    }
                  },
                  child: const Text("Next"),
                ),
              ),

              /// ===== HIỂN THỊ DATA TỪ SCREEN 4 =====
              if (resultData != null) ...[
                const SizedBox(height: 30),
                // const Divider(),
                const Text(
                  "Data from Confirm Page",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text("Email: ${resultData!['email']}"),
                Text("OTP: ${resultData!['otp']}"),
                Text("Password: ${resultData!['password']}"),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/* =======================
   SCREEN 2: VERIFY CODE
======================= */
class VerifyCodePage extends StatelessWidget {
  final String email;
  VerifyCodePage({super.key, required this.email});

  final List<TextEditingController> otpControllers =
      List.generate(5, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 8),
            const Text(
              "SmartTasks",
              style: TextStyle(color: primaryBlue, fontSize: 20),
            ),
            const SizedBox(height: 40),
            const Text(
              "Verify Code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter the code\nwe just sent you on your registered Email",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: otpControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                ),
                onPressed: () {
                  final otp = otpControllers.map((e) => e.text).join();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResetPasswordPage(
                        email: email,
                        otp: otp,
                      ),
                    ),
                  );
                },
                child: const Text("Next"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* =======================
   SCREEN 3: RESET PASSWORD
======================= */
class ResetPasswordPage extends StatelessWidget {
  final String email;
  final String otp;

  ResetPasswordPage({
    super.key,
    required this.email,
    required this.otp,
  });

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 8),
            const Text(
              "SmartTasks",
              style: TextStyle(color: primaryBlue, fontSize: 20),
            ),
            const SizedBox(height: 40),
            const Text(
              "Create new password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your new password must be different form previously used password",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: inputStyle("Password", Icons.lock),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmController,
              obscureText: true,
              decoration: inputStyle("Confirm Password", Icons.lock),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConfirmPage(
                        email: email,
                        otp: otp,
                        password: passwordController.text,
                      ),
                    ),
                  );
                },
                child: const Text("Next"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* =======================
   SCREEN 4: CONFIRM
======================= */
class ConfirmPage extends StatelessWidget {
  final String email;
  final String otp;
  final String password;

  const ConfirmPage({
    super.key,
    required this.email,
    required this.otp,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 8),
            const Text(
              "SmartTasks",
              style: TextStyle(color: primaryBlue, fontSize: 20),
            ),
            const SizedBox(height: 30),
            const Text(
              "Confirm",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "We are here to help you!",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            TextField(
                readOnly: true, decoration: inputStyle(email, Icons.person)),
            const SizedBox(height: 12),
            TextField(readOnly: true, decoration: inputStyle(otp, Icons.email)),
            const SizedBox(height: 12),
            TextField(
              readOnly: true,
              obscureText: true,
              decoration: inputStyle(password, Icons.lock),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(
                    context,
                    {
                      "email": email,
                      "otp": otp,
                      "password": password,
                    },
                  );
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

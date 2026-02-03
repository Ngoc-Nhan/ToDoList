import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authgg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Chưa đăng nhập")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  user.photoURL != null ? NetworkImage(user.photoURL!) : null,
              child: user.photoURL == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),
            const SizedBox(height: 16),

            Text(
              user.displayName ?? "No name",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user.email ?? "",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            // Text("UID: ${user.uid}", style: const TextStyle(fontSize: 12)),
            Spacer(),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(

            //         // padding: EdgeInsets.symmetric(horizontal: 16)
            //         ),
            //     onPressed: () {
            //       Navigator.push(
            //           context, MaterialPageRoute(builder: (_) => AuthScreen()));
            //     },
            //     child: Text('Back')),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => AuthScreen()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // số càng lớn → bo tròn hơn
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 150, vertical: 12), // size button
                  backgroundColor: Colors.blue, // màu nền
                ),
                child: Text(
                  'Back',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

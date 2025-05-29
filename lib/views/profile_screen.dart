import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/user_view_model.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userVM = context.watch<UserViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${userVM.email ?? ''}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userVM.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginGreeting extends StatelessWidget {
  final bool isLogin;
  const LoginGreeting({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isLogin ? 'Welcome!\nLogin To Your \nAccount!' : 'Welcome!\nLet\'s Setup Your \nAccount!',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        Gap(16),
        Text(
          isLogin ? 'Login to continue!' : 'Set up your account to continue!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[500],
          ),
        )
      ]
    );
  }
}

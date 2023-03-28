import 'package:classico/constants/routes.dart';
import 'package:classico/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification.\nPLease open it to verify your account.\n\n"),
          const Text(
              "If you haven't recieved a verification email yeat, press the button below"),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text("Send email verification"),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}

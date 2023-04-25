import 'package:classico/constants/routes.dart';
import 'package:classico/extensions/buildcontext/loc.dart';
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
        title: Text(context.loc.verify_email),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(context.loc.verify_email_view_prompt),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: Text(context.loc.verify_email_send_email_verification),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logout();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                }
              },
              child: Text(context.loc.restart),
            ),
          ],
        ),
      ),
    );
  }
}

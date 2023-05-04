
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
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
           decoration:const  BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/login.jpeg"),
        fit: BoxFit.cover,
      ),
    ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(context.loc.verify_email_view_prompt,style: TextStyle(fontSize: 20),),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: Text(context.loc.verify_email_send_email_verification,style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 20,),
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
              child: Text(context.loc.restart,style: TextStyle(color: Colors.black),),
            ),
            SizedBox(height: 455,)
          ],
        ),
      ),
    ));
  }
}

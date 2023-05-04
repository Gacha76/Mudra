import 'package:classico/constants/routes.dart';
import 'package:classico/extensions/buildcontext/loc.dart';
import 'package:classico/services/auth/auth_exceptions.dart';
import 'package:classico/services/auth/auth_service.dart';
import 'package:classico/utilities/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  //'right-click + rename'
  //Type 'stl/stf' + tab
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController
      _email; // late = doesn't have value now but will have in the future
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.loc.login),
        backgroundColor:Colors.black,
      ),
      body: Container(
        decoration:const  BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/login.jpeg"),
        fit: BoxFit.cover,
      ),
    ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
             const  SizedBox(height: 50),
              Text(context.loc.login_view_prompt, style: TextStyle(fontSize: 20),),
             const SizedBox(height: 60),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
                  hintText: context.loc.email_text_field_placeholder,
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
                  hintText: context.loc.password_text_field_placeholder,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black,foregroundColor: Colors.white),
                //Click on widget name & ctrl + .
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await AuthService.firebase().logIn(
                      email: email,
                      password: password,
                    );
                    final user = AuthService.firebase().currentUser;
                    if (user?.isEmailVerified ?? false) {
                      if (context.mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          notesRoute,
                          (route) => false,
                        );
                      }
                    } else {
                      AuthService.firebase().sendEmailVerification();
                      if (context.mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          verifyEmailRoute,
                          (route) => false,
                        );
                      }
                    }
                  } on UserNotFoundAuthException {
                    await showErrorDialog(
                      context,
                      context.loc.login_error_cannot_find_user,
                    );
                  } on WrongPasswordAuthException {
                    await showErrorDialog(
                      context,
                      context.loc.login_error_wrong_credentials,
                    );
                  } on GenericAuthException {
                    await showErrorDialog(
                      context,
                      context.loc.login_error_auth_error,
                    );
                  }
                },
                child: Text(context.loc.login),
              ),
              
              SizedBox(height: 50,),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    forgotEmailRoute,
                    (route) => false,
                  );
                },
                child: Text(context.loc.login_view_forgot_password),
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                child: Text(context.loc.login_view_not_registered_yet),
              ),
              SizedBox(height: 198,),
            ],
          ),
        ),
      ),
    );
  }
}

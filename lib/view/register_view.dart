import 'package:classico/constants/routes.dart';
import 'package:classico/extensions/buildcontext/loc.dart';
import 'package:classico/services/auth/auth_exceptions.dart';
import 'package:classico/services/auth/auth_service.dart';
import 'package:classico/utilities/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: Text(context.loc.register),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            //Ctrl + Shift + R
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Ctrl + Shift + F
              Text(context.loc.register_view_prompt),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: context.loc.email_text_field_placeholder,
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: context.loc.password_text_field_placeholder,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      //Click on widget name & ctrl + .
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          await AuthService.firebase().createUser(
                            email: email,
                            password: password,
                          );
                          AuthService.firebase().sendEmailVerification();
                          if (context.mounted) {
                            Navigator.of(context).pushNamed(verifyEmailRoute);
                          }
                        } on WeakPasswordAuthException {
                          await showErrorDialog(
                            context,
                            context.loc.register_error_weak_password,
                          );
                        } on EmailAlreadyInUseAuthException {
                          await showErrorDialog(
                            context,
                            context.loc.register_error_email_already_in_use,
                          );
                        } on InvalidEmailAuthException {
                          await showErrorDialog(
                            context,
                            context.loc.register_error_invalid_email,
                          );
                        } on GenericAuthException {
                          await showErrorDialog(
                            context,
                            context.loc.register_error_generic,
                          );
                        }
                      },
                      child: Text(context.loc.register),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                        );
                      },
                      child: Text(context.loc.register_view_already_registered),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

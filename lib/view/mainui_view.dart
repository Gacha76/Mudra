import 'package:classico/constants/routes.dart';
import 'package:classico/services/auth/bloc/auth_bloc.dart';
import 'package:classico/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => context.read<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mudra'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
                child: const Text('Log in'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(mapsRoute);
                },
                child: const Text('Maps'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

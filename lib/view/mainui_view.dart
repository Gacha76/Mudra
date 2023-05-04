import 'package:classico/constants/routes.dart';
import 'package:classico/services/auth/bloc/auth_bloc.dart';
import 'package:classico/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => context.read<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text('Mudra: Health at your fingertips'),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/login.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50.0),
              const Text(
                "Welcome to Mudra : Health at your fingetips!",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
              ),
              const Text(
                "Mudra Provides a platform for assisting patients in their medical history and prescriptions!",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
              ),
              
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                   style:
                  ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black),
                onPressed: () {
               
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
                child: const Text('Log in'),
              ),
              
              const SizedBox(height: 80.0),
              const Text("Tap on map to view nearby Hospitals and medical stores",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 19),),
              SizedBox(height: 40,),
              ElevatedButton(
                   style:
                  ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.of(context).pushNamed(mapbox);
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

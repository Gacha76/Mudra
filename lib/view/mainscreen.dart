

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screen();
}

class _Home_screen extends State<Home_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: const Text("Welcome to Mudra"),
      backgroundColor: Colors.black,

     ),
     body: Container(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.stretch,
  
            children: [
              
              SizedBox(height: 30,),
              const Text("Welcome to the mudra app"),
                  
            
          ]),
          ),
      
     ),
    );
  }
}
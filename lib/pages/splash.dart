import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF9933),
                Color.fromARGB(255, 255, 255, 255), // saffron
                Color(0xFF138808),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                  
                    child: Text(
                      "v1.0.0",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 97, 91, 91),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 350),
              Center(
                child: Icon(
                  Icons.how_to_vote_outlined ,
                  size: 100,
                  color: Color.fromARGB(255, 34, 0, 255),
                ),
              ),
              SizedBox(height: 20),
              const Center(
                child: Text(
                  'E-Voting',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 34, 0, 255),
                  ),
                ),
              ),
              SizedBox(height: 200),
              CircularProgressIndicator(
                color: const Color.fromARGB(255, 105, 140, 246),
              ),
              SizedBox(height: 60),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'copyright @ 2026',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 97, 91, 91),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

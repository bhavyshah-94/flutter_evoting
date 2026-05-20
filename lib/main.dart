import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/listing.dart';
//import 'package:flutter_application_2/pages/login_page.dart';

void main() {
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ElectionListingPage(),
    );
  }
}
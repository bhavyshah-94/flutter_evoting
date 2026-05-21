import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/voting.dart';
import 'package:flutter_application_2/pages/admin.dart';
import 'package:flutter_application_2/pages/splash.dart';

class FragmentPlaceholder extends StatefulWidget {
  const FragmentPlaceholder({super.key});

  @override
  State<FragmentPlaceholder> createState() => _FragmentPlaceholderState();
}

class _FragmentPlaceholderState extends State<FragmentPlaceholder> { 
  List<List<Object>> data1 = [
    <String>['Mumbai', 'Delhi', 'Bangalore', 'Hyderabad'],
    <String>['BJP', 'Congress', 'AAP', 'Shiv Sena'],
    <String>[
      'Narendra Modi',
      'Sonia Gandhi',
      'Arvind Kejriwal',
      'Uddhav Thackeray',
    ],
    <int>[0, 0, 0, 0],
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Navigator(
              initialRoute: '/splash',
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case '/splash':
                    return MaterialPageRoute(
                      builder: (context) => Splash(),
                    );
                  case '/':
                    return MaterialPageRoute(
                      builder: (context) => voting(data: data1),
                    );
                  case '/admin':
                    return MaterialPageRoute(
                      builder: (context) => AdminPage(data: data1),
                    );
                  default:
                    return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

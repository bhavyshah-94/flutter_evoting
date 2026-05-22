import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/voting.dart';
import 'package:flutter_application_2/pages/admin.dart';
import 'package:flutter_application_2/pages/splash.dart';
import 'package:flutter_application_2/pages/login_page.dart';
import 'package:flutter_application_2/pages/listing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FragmentPlaceholder extends StatefulWidget {
  const FragmentPlaceholder({super.key});

  @override
  State<FragmentPlaceholder> createState() => _FragmentPlaceholderState();
}

class _FragmentPlaceholderState extends State<FragmentPlaceholder> { 
  List<List<Object>> data1 = [
    <String>[],
    <String>[],
    <String>[],
    <int>[0, 0, 0, 0],
  ];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDataFromStorage();
  }

  Future<void> _loadDataFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString('electionData');

    if (storedData != null && storedData.isNotEmpty) {
      try {
        final dynamic jsonData = json.decode(storedData);
        if (jsonData is Map<String, dynamic>) {
          final regions = jsonData['regions'] as List? ?? [];
          final elections = jsonData['elections'] as List? ?? [];

          List<String> parties = [];
          List<String> candidates = [];
          List<int> votes = [];

          for (var election in elections) {
            if (election is Map) {
              parties.add(election['party'] ?? '');
              candidates.add(election['candidate'] ?? '');
              votes.add(election['votes'] ?? 0);
            }
          }

          setState(() {
            data1 = [
              regions.cast<String>(),
              parties,
              candidates,
              votes,
            ];
          });
        }
      } catch (e) {
        print('Error loading data from storage: $e');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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
                    case '/login':
                    return MaterialPageRoute(
                      builder: (context) => LoginPage(data1: data1),
                    ); 
                    case '/listing':
                    return MaterialPageRoute( 
                      builder: (context) => ElectionListingPage(data1: data1),
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

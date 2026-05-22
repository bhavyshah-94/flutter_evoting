import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/voting.dart';

class ElectionListingPage extends StatelessWidget {
  final List<List<Object>> data1;

  ElectionListingPage({super.key, required this.data1});

  final ValueNotifier<String> selectedCityNotifier = ValueNotifier<String>("");

  final List<Map<String, dynamic>> elections = [
    {
      "title": "State Level Election",
      "icon": Icons.account_balance,
      "color": Colors.green,
    },
    {
      "title": "District Level Election",
      "icon": Icons.location_city,
      "color": Colors.blue,
    },
    {
      "title": "Village Level Election",
      "icon": Icons.home_work,
      "color": Colors.orange,
    },
    {
      "title": "Municipal Election",
      "icon": Icons.apartment,
      "color": Colors.purple,
    },
    {
      "title": "College Election", 
      "icon": Icons.school, 
      "color": Colors.red
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cities = data1[0] as List<String>;

    if (selectedCityNotifier.value.isEmpty) {
      selectedCityNotifier.value = cities.first;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elections"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.indigoAccent, fontSize: 30, fontWeight: FontWeight.bold),
        leading: BackButton(color: Colors.indigoAccent),
      ),
      body: Container(
        color: Colors.blue.withAlpha(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ValueListenableBuilder<String>(
            valueListenable: selectedCityNotifier,
            builder: (context, selectedCity, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Your City",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),

                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedCity,
                      items: cities.map((city) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          selectedCityNotifier.value = value;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Running Elections in $selectedCity",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: elections.length,
                      itemBuilder: (context, index) {
                        final election = elections[index];
                        return ElectionCard(
                          title: election["title"],
                          icon: election["icon"],
                          color: election["color"],
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  voting(
                                data: data1,
                              ),
                            ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ElectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const ElectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}

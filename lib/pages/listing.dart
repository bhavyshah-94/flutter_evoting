import 'package:flutter/material.dart';

class ElectionListingPage extends StatefulWidget {
  const ElectionListingPage({super.key});

  @override
  State<ElectionListingPage> createState() => _ElectionListingPageState();
}

class _ElectionListingPageState extends State<ElectionListingPage> {
  String selectedCity = "Vadodara";

  final List<String> cities = [
    "Vadodara",
    "Ahmedabad",
    "Surat",
    "Rajkot",
    "Anand",
  ];

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elections"),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.indigoAccent),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.indigoAccent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.blue.withAlpha(30),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedCity,
                    items: cities.map((city) {
                      return DropdownMenuItem(value: city, child: Text(city));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value!;
                      });
                    },
                  ),
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
                        // =================================
                        // CONNECT YOUR FRIEND'S PAGE HERE
                        // =================================

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DummyPage(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
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
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(190, 174, 174, 0.286),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    )
                  ]
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

// ==========================================
// TEMP PAGE
// REPLACE LATER WITH REAL PAGE
// ==========================================

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Election Details")),
      body: const Center(
        child: Text(
          "Your Friend's Page Will Open Here",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

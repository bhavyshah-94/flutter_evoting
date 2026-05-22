import 'package:flutter/material.dart';
//import 'package:flutter_application_2/pages/voting.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
//import 'listing.dart';
//import 'fragment_placeholder.dart';

class AdminPage extends StatefulWidget {
  final List<List<Object>> data;

  const AdminPage({super.key, required this.data});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // Controllers for adding new items
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _partyController = TextEditingController();
  final TextEditingController _candidateController = TextEditingController();

  @override 
  void initState() {
    super.initState();
    loadData();
  }

  String convertDataToJson(List<List<Object>> data) {
List<String> regions = data[0] as List<String>;
List<String> parties = data[1] as List<String>;
List<String> candidates = data[2] as List<String>;
List<int> votes = data[3] as List<int>;

List<Map<String, dynamic>> electionData = [];
for (int i = 0; i < parties.length; i++) {
  electionData.add({
    'party': parties[i],
    'candidate': candidates[i],
    'votes': votes[i],
  });
}

Map<String, dynamic> jsonData = {
  'regions': regions,
  'elections': electionData,
};

return jsonEncode(jsonData);
}

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      String jsonString = convertDataToJson(widget.data);
      await prefs.setString('electionData', jsonString);
    } catch (e) {
      // ignore write errors for now
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    _partyController.dispose();
    _candidateController.dispose();
    super.dispose();
  }

  void _addCity() {
    if (_cityController.text.isNotEmpty) {
      setState(() {
        widget.data[0].add(_cityController.text.trim());
        _cityController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('City added successfully!')),
      );
    
    }
    loadData();
  }

  void _deleteCity(int index) {
    
    setState(() {
      widget.data[0].removeAt(index);
    });
    loadData();
  }

  void _editCityDialog(int index) {
    TextEditingController editCityCtrl = TextEditingController(
      text: widget.data[0][index] as String,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit City"),
          content: TextField(
            controller: editCityCtrl,
            decoration: const InputDecoration(labelText: "City Name"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (editCityCtrl.text.isNotEmpty) {
                  setState(() {
                    widget.data[0][index] = editCityCtrl.text.trim();
                  });
                  loadData();
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
  void _addParty() {
    if (_partyController.text.isNotEmpty &&
        _candidateController.text.isNotEmpty) {
      setState(() {
        widget.data[1].add(_partyController.text.trim());
        widget.data[2].add(_candidateController.text.trim());
        widget.data[3].add(0); // Initialize votes to 0

        _partyController.clear();
        _candidateController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Party & Candidate added!')),
      );
    }
    loadData();
  }

  void _deleteParty(int index) {
    setState(() {
      widget.data[1].removeAt(index);
      widget.data[2].removeAt(index);
      widget.data[3].removeAt(index);
    });
    loadData();
  }

  void _editPartyDialog(int index) {
    TextEditingController editPartyCtrl = TextEditingController(
      text: widget.data[1][index] as String,
    );
    TextEditingController editCandCtrl = TextEditingController(
      text: widget.data[2][index] as String,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Party & Candidate"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editPartyCtrl,
                decoration: const InputDecoration(labelText: "Party Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: editCandCtrl,
                decoration: const InputDecoration(labelText: "Candidate Name"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (editPartyCtrl.text.isNotEmpty &&
                    editCandCtrl.text.isNotEmpty) {
                  setState(() {
                    widget.data[1][index] = editPartyCtrl.text.trim();
                    widget.data[2][index] = editCandCtrl.text.trim();
                  });
                  loadData();
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> cities = widget.data[0].map((e) => e as String).toList();
    List<String> parties = widget.data[1].map((e) => e as String).toList();
    List<String> candidates = widget.data[2].map((e) => e as String).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.pop(context, '/listing');
          },
        ),
      ),
      body: Container(
        color: Colors.blue.withAlpha(30),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Manage Cities",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              cities.isEmpty
                  ? const Text("No cities added yet.")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(cities[index]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editCityDialog(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteCity(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 20),

              const Text(
                "Manage Parties & Candidates",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              parties.isEmpty
                  ? const Text("No parties added yet.")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: parties.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(parties[index]),
                            subtitle: Text("Candidate: ${candidates[index]}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editPartyDialog(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteParty(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 30),
              const Divider(thickness: 2),
              const SizedBox(height: 20),
              const Text(
                "Add New City",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                        controller: _cityController,
                        decoration: const InputDecoration(
                          labelText: 'City Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _addCity,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Add City"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Add New Party & Candidate",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                        controller: _partyController,
                        decoration: const InputDecoration(
                          labelText: 'Party Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _candidateController,
                        decoration: const InputDecoration(
                          labelText: 'Candidate Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _addParty,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Add Party & Candidate"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30), // Padding for the bottom of the screen
            ],
          ),
        ),
      ),
    );
  }        
}
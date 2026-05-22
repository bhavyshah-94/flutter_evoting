import 'package:flutter/material.dart';
//import 'package:flutter_application_2/pages/admin.dart';

class voting extends StatefulWidget {
  final List<List<Object>> data;

  const voting({super.key, required this.data});

  @override
  State<voting> createState() => _votingState();
}

class _votingState extends State<voting> {
  int? selectedPartyIndex;

  // Default emojis for the first 4 parties. Extras will default to a flag.
  final List<String> defaultEmojis = ["🪷", "✋", "🧹", "🏹"];

  @override
  Widget build(BuildContext context) {
    // Extracting parties safely to use for mapping
    List<Object> parties = widget.data[1];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.indigoAccent),
          onPressed: () {
            Navigator.pop(context, '/listing');
          },
        ),
        title: const Text("Voting App"),
        centerTitle: true,
        titleTextStyle: const TextStyle(  
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.indigoAccent,
        ),
      ),
      body: Container(
        color: Colors.blue.withAlpha(30),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Vote for your favourite party",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // --- DYNAMICALLY RENDERED VOTING CARDS ---
                ...parties.asMap().entries.map((entry) {
                  int index = entry.key;
                  String partyName = entry.value.toString();
                  String candidateName = widget.data[2][index].toString();

                  // Assign emoji based on index, fallback to a flag if more than 4 parties
                  String emoji = index < defaultEmojis.length
                      ? defaultEmojis[index]
                      : "🚩";

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Text(
                                emoji,
                                style: const TextStyle(fontSize: 24),
                              ),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    candidateName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "$partyName Description",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Radio<int>(
                              value: index, // Using the list index as the value
                              groupValue: selectedPartyIndex,
                              onChanged: (value) {
                                setState(() {
                                  selectedPartyIndex = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: selectedPartyIndex != null
                      ? () {
                          setState(() {
                            (widget.data[3]
                                as List<int>)[selectedPartyIndex!]++;
                            selectedPartyIndex = null;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vote cast successfully!'),
                              ),
                            );
                          });
                        }
                      : null,
                  child: const Text("Submit Vote"),
                ),

                const SizedBox(height: 20),
                const Divider(),

                const Text(
                  "Total Votes",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Wrap(
                  spacing: 30,
                  runSpacing: 15,
                  alignment: WrapAlignment.center,
                  children: parties.asMap().entries.map((entry) {
                    int index = entry.key;
                    String partyName = entry.value.toString();
                    String voteCount = widget.data[3][index].toString();
                    List<Color> colors = [
                      Colors.blue,
                      Colors.red,
                      Colors.green,
                      Colors.orange,
                    ];
                    Color countColor = colors[index % colors.length];

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          partyName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          voteCount,
                          style: TextStyle(
                            fontSize: 18,
                            color: countColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

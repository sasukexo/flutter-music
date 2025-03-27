import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'home_screen.dart';

class ArtistSelectionScreen extends StatefulWidget {
  @override
  _ArtistSelectionScreenState createState() => _ArtistSelectionScreenState();
}

class _ArtistSelectionScreenState extends State<ArtistSelectionScreen> {
  String selectedArtist = "Zayn Malik"; // Default artist

  List<String> artists = [
    "Zayn Malik",
    "One Direction",
    "Ed Sheeran",
    "Kendrick Lamar",
    "Lewis Capaldi",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Artist")),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Choose an Artist",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedArtist,
                  isExpanded: true,
                  icon: Icon(Icons.music_note, color: Colors.blueAccent),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  dropdownColor: Colors.white,
                  items: artists.map((String artist) {
                    return DropdownMenuItem<String>(
                      value: artist,
                      child: Text(artist),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedArtist = newValue!;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(artist: selectedArtist),
                      ),
                    );
                  },
                  child: Text("Continue"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

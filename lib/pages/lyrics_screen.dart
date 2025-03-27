import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LyricsScreen extends StatefulWidget {
  final String artist;

  LyricsScreen({required this.artist});

  @override
  _LyricsScreenState createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  TextEditingController _songController = TextEditingController();
  String _lyrics = "";
  bool _isLoading = false;

  Future<void> fetchLyrics(String song) async {
    setState(() {
      _isLoading = true;
      _lyrics = ""; // Clear previous lyrics
    });

    final apiUrl =
        "https://api.lyrics.ovh/v1/${widget.artist}/$song"; // Public API

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _lyrics = data["lyrics"] ?? "No lyrics found.";
        });
      } else {
        setState(() {
          _lyrics = "Lyrics not found!";
        });
      }
    } catch (e) {
      setState(() {
        _lyrics = "Error fetching lyrics. Please try again.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.artist} Lyrics")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _songController,
              decoration: InputDecoration(
                labelText: "Enter Song Name",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_songController.text.isNotEmpty) {
                      fetchLyrics(_songController.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        _lyrics.isNotEmpty ? _lyrics : "Search for a song...",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

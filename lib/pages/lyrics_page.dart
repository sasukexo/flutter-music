import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LyricsPage extends StatefulWidget {
  final String artist;
  LyricsPage({required this.artist});

  @override
  _LyricsPageState createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  String lyrics = "Fetching lyrics...";

  @override
  void initState() {
    super.initState();
    fetchLyrics();
  }

  Future<void> fetchLyrics() async {
    final response = await http.get(Uri.parse("https://api.lyrics.ovh/v1/${widget.artist}/random_song"));

    if (response.statusCode == 200) {
      setState(() {
        lyrics = json.decode(response.body)["lyrics"] ?? "No lyrics found!";
      });
    } else {
      setState(() {
        lyrics = "Failed to fetch lyrics.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lyrics for ${widget.artist}")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(lyrics, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

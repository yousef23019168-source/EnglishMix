import 'package:flutter/material.dart';

import '../models/word.dart';
import '../services/tts_service.dart';

class WordsScreen extends StatefulWidget {
  final String title;
  final List<Word> items;

  const WordsScreen({super.key, required this.title, required this.items});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  final TtsService _ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    _ttsService.initialize();
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final Word word = widget.items[index];

          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              title: Text(
                word.english,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(word.arabic, style: const TextStyle(fontSize: 16)),
              trailing: IconButton.filled(
                onPressed: () {
                  _ttsService.speak(word.english);
                },
                style: IconButton.styleFrom(foregroundColor: Colors.white),
                icon: const Icon(Icons.volume_up),
                tooltip: 'Listen',
              ),
            ),
          );
        },
      ),
    );
  }
}

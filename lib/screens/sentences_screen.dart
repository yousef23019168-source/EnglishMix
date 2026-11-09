import 'package:flutter/material.dart';

import '../models/sentence.dart';
import '../services/tts_service.dart';

class SentencesScreen extends StatefulWidget {
  final String title;
  final List<Sentence> items;

  const SentencesScreen({super.key, required this.title, required this.items});

  @override
  State<SentencesScreen> createState() => _SentencesScreenState();
}

class _SentencesScreenState extends State<SentencesScreen> {
  final TtsService _ttsService = TtsService();

  final Set<String> _visibleTranslations = {};

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

  void _toggleTranslation(String id) {
    setState(() {
      if (_visibleTranslations.contains(id)) {
        _visibleTranslations.remove(id);
      } else {
        _visibleTranslations.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.items.length,

        itemBuilder: (context, index) {
          final Sentence sentence = widget.items[index];

          final bool isTranslationVisible = _visibleTranslations.contains(
            sentence.id,
          );

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sentence.english,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (isTranslationVisible)
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          sentence.arabic,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _toggleTranslation(sentence.id);
                        },
                        icon: Icon(
                          isTranslationVisible
                              ? Icons.visibility_off
                              : Icons.translate,
                        ),
                        label: Text(
                          isTranslationVisible
                              ? 'Hide Translation'
                              : 'Show Translation',
                        ),
                      ),

                      IconButton.filled(
                        onPressed: () {
                          _ttsService.speak(sentence.english);
                        },
                        icon: const Icon(Icons.volume_up),
                        tooltip: 'Listen',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

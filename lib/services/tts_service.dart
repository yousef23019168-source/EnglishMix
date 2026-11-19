import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();
  late final Future<void> _initialization = _initialize();

  Future<void> initialize() async {
    await _initialization;
  }

  Future<void> _initialize() async {
    try {
      await _tts.setLanguage('en-US');
      await _tts.setSpeechRate(0.45);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);
      debugPrint('TTS initialized successfully.');
    } catch (error, stackTrace) {
      debugPrint('TTS initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> speak(String text) async {
    try {
      await initialize();
      await _tts.stop();
      final result = await _tts.speak(text);
      debugPrint('TTS speak result: $result');
    } catch (error, stackTrace) {
      debugPrint('TTS playback failed for "$text": $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (error) {
      debugPrint('TTS stop failed: $error');
    }
  }

  Future<void> setSpeed(double speed) async {
    try {
      await initialize();
      await _tts.setSpeechRate(speed);
    } catch (error, stackTrace) {
      debugPrint('TTS speed update failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}

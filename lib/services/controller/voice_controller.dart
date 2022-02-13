import 'dart:math';
import 'package:dart_sentiment/dart_sentiment.dart';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../models/user_model.dart';

class VoiceDetector {
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = 'I love doing jobs and I am a clever person';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  int sentimentResult = 0;
  final SpeechToText speech = SpeechToText();


  Future<void> initSpeechState() async {
    if (kDebugMode) {
      print('Initialize');
    }

    var hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
      debugLogging: true,
    );
    if (hasSpeech) {
      // Get the list of languages installed on the supporting platform so they
      // can be displayed in the UI for selection by the user.

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
      if (kDebugMode) {
        print("THIS IS THE LANGUAGE");
        print(_currentLocaleId);
      }
    }
  }

  void startListening() {
    if (kDebugMode) {
      print('start listening');
    }
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: const Duration(seconds: 3600),
        pauseFor: const Duration(seconds: 1800),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }

  void stopListening(UserModel user) {
    if (kDebugMode) {
      print('stop');
      print(lastWords);
    }

    final sentiment = Sentiment();
    sentimentResult = sentiment.analysis(lastWords)["score"];
    user.sentimentScores.add(sentimentResult);
    speech.stop();
    level = 0.0;
  }

  void resultListener(SpeechRecognitionResult result) {
    if (kDebugMode) {
      print(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    }
    lastWords = '${result.recognizedWords} - ${result.finalResult}';
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    this.level = level;
  }

  void errorListener(SpeechRecognitionError error) {
    if (kDebugMode) {
      print(
        'Received error status: $error, listening: ${speech.isListening}');
    }

    lastError = '${error.errorMsg} - ${error.permanent}';

  }

  void statusListener(String status) {
    if (kDebugMode) {
      print(
        'Received listener status: $status, listening: ${speech.isListening}');
    }
    lastStatus = status;
  }
}
import 'dart:math';
import 'package:dart_sentiment/dart_sentiment.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../models/user_model.dart';

class VoiceDetector {
  bool _hasSpeech = false;
  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = 'I love doing jobs and I am a clever person';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  int sentimentResult = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();


  Future<void> initSpeechState() async {
    print('Initialize');

    var hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
      debugLogging: true,
    );
    if (hasSpeech) {
      // Get the list of languages installed on the supporting platform so they
      // can be displayed in the UI for selection by the user.
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
      print("THIS IS THE LANGUAGE");
      print(_currentLocaleId);
    }
    _hasSpeech = hasSpeech;
  }

  void startListening() {
    print('start listening');
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 3600),
        pauseFor: Duration(seconds: 1800),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }

  void stopListening(UserModel user) {
    print('stop');
    print(lastWords);
    final sentiment = Sentiment();
    sentimentResult = sentiment.analysis(lastWords)["score"];
    print(sentimentResult);
    user.sentimentScores.add(sentimentResult);
    speech.stop();
    level = 0.0;
  }

  void resultListener(SpeechRecognitionResult result) {
    print(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    lastWords = '${result.recognizedWords} - ${result.finalResult}';
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    this.level = level;
  }

  void errorListener(SpeechRecognitionError error) {
    print(
        'Received error status: $error, listening: ${speech.isListening}');

    lastError = '${error.errorMsg} - ${error.permanent}';

  }

  void statusListener(String status) {
    print(
        'Received listener status: $status, listening: ${speech.isListening}');
    lastStatus = '$status';
  }
}
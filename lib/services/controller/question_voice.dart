import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class QuestionVoice {
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 1.0;
  double pitch = 0.3;
  double rate = 0.53;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  void setVoiceText(String text){
    _newVoiceText = text;
  }

  Future speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      if (kDebugMode) {
        print(engine);
      }
    }
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
    }

    flutterTts.setStartHandler(() {
        if (kDebugMode) {
          print("Playing");
        }
        ttsState = TtsState.playing;
    });

    flutterTts.setCompletionHandler(() {
        if (kDebugMode) {
          print("Complete");
        }
        ttsState = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
        if (kDebugMode) {
          print("Cancel");
        }
        ttsState = TtsState.stopped;
    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {
          if (kDebugMode) {
            print("Paused");
          }
          ttsState = TtsState.paused;
      });

      flutterTts.setContinueHandler(() {
          if (kDebugMode) {
            print("Continued");
          }
          ttsState = TtsState.continued;
      });
    }

    flutterTts.setErrorHandler((msg) {
        if (kDebugMode) {
          print("error: $msg");
        }
        ttsState = TtsState.stopped;
    });
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }


}
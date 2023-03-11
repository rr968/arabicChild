import 'dart:convert';
import 'dart:io';

import 'package:arabic_speaker_child/controller/my_provider.dart';
import 'package:provider/provider.dart';

import '/controller/api.dart';
import '/controller/checkinternet.dart';
import '/controller/functionsspeak.dart';
import '/controller/var.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

final FlutterTts fluttertts = FlutterTts();
speakTts(text) async {
  await fluttertts.setLanguage('ar');
  Map<String, String> v = isFemale
      ? {"name": "ar-xa-x-arz-local", "locale": "ar"}
      : {"name": "ar-xa-x-ard-local", "locale": "ar"};
  fluttertts.setVoice(v);
  fluttertts.speak(text);
}

Future getspeech(String text, String name) async {
  final String audio = await TextToSpeechAPI().synthesizeText(text, name, "ar");
  final bytes = const Base64Decoder().convert(audio, 0, audio.length);
  final dir = await getTemporaryDirectory();
  final file = File("${dir.path}/wavenet.mp3");
  await file.writeAsBytes(bytes);
  final player = AudioPlayer(); // Create a player
  await player.setFilePath(file.path); // Play without waiting for completion
  await player.play();
}

Future howtospeak(String text, context) async {
  String voiceGoogleCloud = isFemale ? "ar-XA-Wavenet-A" : "ar-XA-Wavenet-B";
  internetConnection().then((value) {
    if (value == true) {
      Provider.of<MyProvider>(context, listen: false).setIsSpeakingNow(true);
      getspeech(modifyTextBeforeSpeak(text), voiceGoogleCloud).then((value) {
        Provider.of<MyProvider>(context, listen: false).setIsSpeakingNow(false);
      });
    } else {
      speakTts(modifyTextBeforeSpeak(text));
    }
  });
}

String modifyTextBeforeSpeak(String text) {
  String finaltext = text.trim();

  //finaltext = pronounceShaddaIOS(finaltext);
  finaltext = harakatOnFirstWord(finaltext);
  finaltext = someWords(finaltext);
  finaltext = putHarakatOnSomeWords(finaltext);
  try {
    finaltext = TurnTaaToHaa(finaltext);
  } catch (_) {}

  //finaltext = TurnAToAA(finaltext);
  //finaltext = preRplace(finaltext);

  finaltext = scoonAtLast(finaltext);
  finaltext = putDot(finaltext);

  //finaltext = putDotAfterAllWords(finaltext);

  return finaltext;
}

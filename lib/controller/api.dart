// ignore_for_file: file_names

import 'dart:io';
import 'dart:async';
import 'dart:convert' show json, utf8;

import '../model/mykey.dart';

class TextToSpeechAPI {
  static final TextToSpeechAPI _singleton = TextToSpeechAPI._internal();
  final _httpClient = HttpClient();
  static const _apiURL = "texttospeech.googleapis.com";

  factory TextToSpeechAPI() {
    return _singleton;
  }

  TextToSpeechAPI._internal();

  Future<dynamic> synthesizeText(
      String text, String name, String languageCode) async {
    try {
      final uri = Uri.https(_apiURL, '/v1beta1/text:synthesize');
      final Map json = {
        'input': {'text': text},
        'voice': {'name': name, 'languageCode': languageCode},
        'audioConfig': {'audioEncoding': 'MP3'}
      };

      final jsonResponse = await _postJson(uri, json);
      final String audioContent = await jsonResponse['audioContent'];
      return audioContent;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>> _postJson(Uri uri, Map jsonMap) async {
    try {
      final httpRequest = await _httpClient.postUrl(uri);
      final jsonData = utf8.encode(json.encode(jsonMap));
      final jsonResponse =
          await _processRequestIntoJsonResponse(httpRequest, jsonData);
      return jsonResponse;
    } on Exception catch (_) {
      return {};
    }
  }

  Future<Map<String, dynamic>> _processRequestIntoJsonResponse(
      HttpClientRequest httpRequest, List<int> data) async {
    try {
      httpRequest.headers.add('X-Goog-Api-Key', APIKeyService.fetch());
      httpRequest.headers
          .add(HttpHeaders.contentTypeHeader, 'application/json');
      httpRequest.add(data);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        throw Exception('Bad Response');
      }
      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch (_) {
      return {};
    }
  }
}

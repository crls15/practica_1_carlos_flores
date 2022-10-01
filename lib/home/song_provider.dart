import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:practica_1_carlos_flores/home/http_requests.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;

import '../song/Song.dart';

class SongProvider with ChangeNotifier {
  final record = Record();
  Map<String, dynamic>? song_json_obj;
  bool animationOn = false;
  String topString = 'Toque para escuchar';

  List<Song> songs_list = <Song>[];

  void addToFavorites(Song song) {
    songs_list.add(song);
    notifyListeners();
  }

  void deleteFromFavorites(Song song) {
    songs_list.remove(song);
    notifyListeners();
  }

  void changeAnimationOn() {
    if (animationOn) {
      topString = 'Toque para escuchar';
    } else {
      topString = 'Escuchando...';
    }

    animationOn = !animationOn;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> startRecording() async {
    if (await record.hasPermission()) {
      await record.start();
    }

    bool isRecording = await record.isRecording();

    if (isRecording) {
      await Future.delayed(Duration(seconds: 5));
      final record_data = await record.stop();

      File record_file = File(record_data!);
      Uint8List record_file_as_bytes = record_file.readAsBytesSync();
      String record_file_base_64 = base64Encode(record_file_as_bytes);
      print(record_file_base_64);

      var response = await HttpRequests().postRequest(record_file_base_64);

      // Map<String, dynamic> body = {
      //   "api_token": "3d607b26fa49c544359514324338233f",
      //   "audio": "${record_file_base_64}",
      //   "return": 'apple_music,spotify,deezer',
      //   "method": 'recognize',
      // };
      // await http.post(
      //   Uri.parse('https://api.audd.io/'),
      //   body: json.encode(body),
      // );

      if (response.statusCode == 200) {
        song_json_obj = jsonDecode(response.body);
        print(jsonDecode(response.body));
        notifyListeners();
      } else {
        throw Exception('Status: ${response.statusCode}');
      }

      return song_json_obj;
    }
  }
}

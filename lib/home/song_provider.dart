import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // List<Song> songs_list = <Song>[];

  void addToFavorites(Song song) async {
    Map<String, dynamic> song_map = {
      'artist': song.artist,
      'title': song.title,
      'album': song.album,
      'release_date': song.release_date,
      'imageURL': song.imageURL,
      'appleMusicURL': song.appleMusicURL,
      'spotifyURL': song.spotifyURL,
      'generalURL': song.generalURL
    };

    var user = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    var favorite_songs = user.collection("favorite_songs");
    await favorite_songs.add(song_map);

    // songs_list.add(song);
    notifyListeners();
  }

  void deleteFromFavorites(Song song) async {
    var user = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    QuerySnapshot<Map<String, dynamic>> favorite_songs =
        await user.collection("favorite_songs").get();

    for (var doc in favorite_songs.docs) {
      if (doc["title"] == song.title) {
        await doc.reference.delete();
      }
    }
    notifyListeners();
  }

  Future<List<Song>> getFavorites() async {
    var user = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    QuerySnapshot<Map<String, dynamic>> favorite_songs =
        await user.collection("favorite_songs").get();

    List<Song> favorite_songs_list = [];

    for (var doc in favorite_songs.docs) {
      favorite_songs_list.add(
        Song(
          album: doc.data()['album'],
          artist: doc.data()['artist'],
          title: doc.data()['title'],
          release_date: doc.data()['release_date'],
          imageURL: doc.data()['imageURL'],
          appleMusicURL: doc.data()['appleMusicURL'],
          spotifyURL: doc.data()['spotifyURL'],
          generalURL: doc.data()['generalURL'],
        ),
      );
      // favorite_songs_list.add(Song.fromJson(doc.data()));
    }
    notifyListeners();
    return favorite_songs_list;
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

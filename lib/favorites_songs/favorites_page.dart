import 'package:flutter/material.dart';
import 'package:practica_1_carlos_flores/favorites_songs/favorite_song.dart';
import 'package:practica_1_carlos_flores/song/Song.dart';
import 'package:provider/provider.dart';

import '../home/song_provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    List<Song> favorite_songs = context.read<SongProvider>().songs_list;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: favorite_songs.length,
        itemBuilder: (BuildContext context, int index) {
          Song song_instance = favorite_songs[index];
          return FavoriteSong(song: song_instance);
        },
      ),
    );
  }
}

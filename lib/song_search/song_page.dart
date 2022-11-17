import 'package:flutter/material.dart';
import 'package:practica_1_carlos_flores/song_search/url_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/song_provider.dart';
import '../song/Song.dart';

class SongPage extends StatefulWidget {
  final Song song;
  const SongPage({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Here you go'),
            IconButton(
              onPressed: () {
                _showMyDialog(context);
              },
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: 400,
            ),
            child: Image.network(
              '${widget.song.imageURL}',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 32,
              bottom: 16,
            ),
            child: Column(children: [
              Text(
                '${widget.song.title}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${widget.song.album}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                '${widget.song.artist}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              Text(
                '${widget.song.release_date}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Abrir con:',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UrlButton(
                  url: widget.song.spotifyURL,
                  icon_image_path: 'assets/images/spotifyLogo.png',
                  destiny_name: 'Spotify',
                ),
                UrlButton(
                  url: widget.song.generalURL,
                  icon_image_path: 'assets/images/podcastLogo.png',
                  destiny_name: 'Web',
                ),
                UrlButton(
                  url: widget.song.appleMusicURL,
                  icon_image_path: 'assets/images/appleLogo.png',
                  destiny_name: 'Web',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(context) async {
    List<Song> favorite_songs = await SongProvider().getFavorites();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        bool flag = false;

        for (var fav_song in favorite_songs) {
          if (fav_song.title == widget.song.title) {
            flag = true;
            break;
          }
        }

        if (flag) {
          return AlertDialog(
            title: const Text('Quitar de favoritos'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Quieres eliminar esta canción de tus favoritos?.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  context.read<SongProvider>().deleteFromFavorites(widget.song);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text('Se quito con éxito...'),
                      ),
                    );

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }

        return AlertDialog(
          title: const Text('Agregar a favoritos'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Quieres agregar esta canción a tus favoritos?.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                context.read<SongProvider>().addToFavorites(widget.song);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('Se agregó con éxito...')),
                  );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

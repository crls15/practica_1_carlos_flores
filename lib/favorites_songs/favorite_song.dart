import 'package:flutter/material.dart';
import 'package:practica_1_carlos_flores/home/home_page.dart';
import 'package:practica_1_carlos_flores/song/Song.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/song_provider.dart';

class FavoriteSong extends StatefulWidget {
  final Song? song;
  const FavoriteSong({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  State<FavoriteSong> createState() => _FavoriteSongState();
}

class _FavoriteSongState extends State<FavoriteSong> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: 100,
      padding: EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          onTap: () {
            _launchInBrowser(context, widget.song?.generalURL);
          },
          child: Stack(
            children: [
              Positioned(
                child: Image.network(
                  '${widget.song?.imageURL}',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        maxHeight: 60,
                      ),
                      color: Color.fromARGB(222, 37, 78, 190),
                      child: Column(
                        children: [
                          Text(
                            '${widget.song?.title}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${widget.song?.artist}',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              Positioned(
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    _showMyDialog(context);
                  },
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
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
                context.read<SongProvider>().deleteFromFavorites(widget.song!);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('Se quito con éxito...'),
                    ),
                  );

                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchInBrowser(context, url) async {
    if (url == '') {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('No se encontró el sitio')),
        );
    } else if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }
}

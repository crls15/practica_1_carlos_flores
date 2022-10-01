import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:practica_1_carlos_flores/home/song_provider.dart';
import 'package:practica_1_carlos_flores/song/Song.dart';
import 'package:provider/provider.dart';
import '../song_search/song_page.dart';

class HearingButton extends StatefulWidget {
  const HearingButton({
    Key? key,
  }) : super(key: key);

  @override
  State<HearingButton> createState() => _HearingButtonState();
}

class _HearingButtonState extends State<HearingButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<SongProvider>().changeAnimationOn();
        var jsonSong = await context.read<SongProvider>().startRecording();
        context.read<SongProvider>().changeAnimationOn();

        if (jsonSong != null && jsonSong['result'] != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SongPage(
                song: Song.fromJson(jsonSong),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content:
                      Text('No se encontró la canción, intentelo de nuevo')),
            );
        }
      },
      child: AvatarGlow(
        animate: context.watch<SongProvider>().animationOn,
        glowColor: Colors.red,
        endRadius: 160.0,
        duration: Duration(milliseconds: 2000),
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Image.asset(
              'assets/images/botonFondo.png',
              height: 100,
            ),
            radius: 80.0,
          ),
        ),
      ),
    );
  }
}

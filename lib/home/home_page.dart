import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica_1_carlos_flores/home/hearing_button.dart';
import 'package:practica_1_carlos_flores/home/song_provider.dart';
import 'package:provider/provider.dart';
import 'package:practica_1_carlos_flores/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../favorites_songs/favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                context.watch<SongProvider>().topString,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HearingButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () async {
                    // BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                    var favorite_songs = await SongProvider().getFavorites();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FavoritesPage(
                          favorite_songs: favorite_songs,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.favorite),
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () async {
                    BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                  },
                  icon: Icon(Icons.power_off),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

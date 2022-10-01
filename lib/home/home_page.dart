import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica_1_carlos_flores/home/hearing_button.dart';
import 'package:practica_1_carlos_flores/home/song_provider.dart';
import 'package:provider/provider.dart';

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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FavoritesPage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.favorite),
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

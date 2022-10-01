import 'package:flutter/material.dart';
import 'package:practica_1_carlos_flores/home/song_provider.dart';
import 'package:provider/provider.dart';

import 'home/home_page.dart';

void main() => runApp(
      ChangeNotifierProvider<SongProvider>(
        create: (context) => SongProvider(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Material App',
      home: HomePage(),
    );
  }
}

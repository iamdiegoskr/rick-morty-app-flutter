import 'package:aplicacion_rick_morty_rest/screens/character_detail.dart';
import 'package:aplicacion_rick_morty_rest/screens/home_page.dart';
import 'package:aplicacion_rick_morty_rest/services/character_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> CharactersProvider(), lazy: false)
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: HomePageCharacters.routeName,
      routes: {
        HomePageCharacters.routeName : (_) => const HomePageCharacters(),
        CharacterDetail.routeName : (_) => const CharacterDetail()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green
        )
      ),
    );
  }
}
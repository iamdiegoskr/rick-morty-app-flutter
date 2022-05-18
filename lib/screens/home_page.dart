import 'package:aplicacion_rick_morty_rest/screens/characters_page.dart';
import 'package:aplicacion_rick_morty_rest/services/character_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageCharacters extends StatelessWidget {
  const HomePageCharacters({Key? key}) : super(key: key);

  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {

    CharactersProvider charactersProvider = Provider.of<CharactersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick & Morty'),
        centerTitle: true,
        elevation: 0,
      ),
      body:  charactersProvider.myCharacters.isEmpty
        ? const Center(child: CircularProgressIndicator()) : CharactersContain(charactersProvider: charactersProvider),
    );
  }
}

class CharactersContain extends StatelessWidget {
  const CharactersContain({
    Key? key,
    required this.charactersProvider,
  }) : super(key: key);

  final CharactersProvider charactersProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
    child: CharactersPage(
      characters: charactersProvider.myCharacters,
      nextPageCharacters: ()=> charactersProvider.getCharacters(),
    ),
      );
  }
}
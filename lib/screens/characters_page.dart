

import 'package:aplicacion_rick_morty_rest/widgets/character_card.dart';
import 'package:flutter/material.dart';


import '../models/character.dart';

class CharactersPage extends StatefulWidget {

  final List<Character> characters;
  final Function nextPageCharacters;

  const CharactersPage({
    Key? key,
    required this.characters,
    required this.nextPageCharacters
    }) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        widget.nextPageCharacters();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double crossAxisSpacing = 12, mainAxisSpacing = 10, aspectRatio = 0.7;
    int crossAxisCount = 2;

    return GridView.builder(
      controller: scrollController,
      itemCount: widget.characters.length,
      padding: const EdgeInsets.all(5.0),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (BuildContext context, int index){
        return  CharacterCard(character: widget.characters[index]);
      });
  }
}


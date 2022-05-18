import 'package:flutter/material.dart';

import '../models/character.dart';
class PosterDetail extends StatelessWidget {
  const PosterDetail({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 140,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
            color: Color.fromARGB(255, 109, 109, 109),
            spreadRadius: 4,
            blurRadius: 7,
            offset: Offset(7.0, 8.0)
            ),
          ]
        ),
        child:  FadeInImage(
          fit: BoxFit.cover,
          image: NetworkImage(character.image!),
          placeholder: const AssetImage('assets/loadingicon.gif'),
        ),
      ),
    );
  }
}
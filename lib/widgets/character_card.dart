import 'package:aplicacion_rick_morty_rest/screens/character_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/character.dart';

class CharacterCard extends StatelessWidget {

  final Character character;

  const CharacterCard({
    Key? key,
    required this.character
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, CharacterDetail.routeName, arguments: character),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade300,
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(4.0,4.0)//pensar en un plano cartesiano (x
              ),
          ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageCharacter(characterPoster: character.image, status: character.status,),
              const SizedBox(height: 14,),
              Text(
                character.name,
                style: GoogleFonts.zenLoop(fontSize:22, fontWeight: FontWeight.bold, letterSpacing: 1.3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImageCharacter extends StatelessWidget {


  final String? characterPoster;
  final String status;

  const ImageCharacter({
    Key? key,
    required this.characterPoster,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          SizedBox(
          height: 210,
          width: double.infinity,
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: const AssetImage('assets/loadingicon.gif'),
            image: NetworkImage(characterPoster ?? 'https://via.placeholder.com/300x400'),
          )
        ),
        Positioned(
          left: 4,
          top: 4,
          child: Icon(Icons.circle, color: statusColorCharacter(status),size: 18,)
        )
      ],
    );
  }
}

Color statusColorCharacter(String status){
  String statusCharacter = status.toLowerCase();
  switch(statusCharacter){
    case 'alive' : {
      return Colors.greenAccent;
    }
    case 'dead' : {
      return Colors.redAccent;
    }
    default:{
      return Colors.white;
    }
  }
}
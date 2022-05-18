

import 'package:aplicacion_rick_morty_rest/models/origen.dart';
import 'package:aplicacion_rick_morty_rest/services/character_services.dart';
import 'package:aplicacion_rick_morty_rest/utils/utils.dart';
import 'package:aplicacion_rick_morty_rest/widgets/poster_detail.dart';
import 'package:aplicacion_rick_morty_rest/widgets/sliverappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/character.dart';

class CharacterDetail extends StatelessWidget {
  const CharacterDetail({Key? key}) : super(key: key);

  static const routeName = 'character-detail';

  @override
  Widget build(BuildContext context) {

    final character = ModalRoute.of(context)!.settings.arguments as Character;

    final CharactersProvider charactersProvider = Provider.of<CharactersProvider>(context);

    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 180,
            flexibleSpace: ImageBackgroundAppBar(name: character.name) ,
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              PosterAndInformationGeneral(character: character),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Divider(thickness: 2, color: Color.fromARGB(255, 77, 230, 82),),
              ),
              const SizedBox(height: 14,),
              OrigenCharacter(charactersProvider: charactersProvider, character: character)
            ]
          ))
        ]
      ),
    );
  }
}

class OrigenCharacter extends StatefulWidget {
  const OrigenCharacter({
    Key? key,
    required this.charactersProvider,
    required this.character,
  }) : super(key: key);

  final CharactersProvider charactersProvider;
  final Character character;

  @override
  State<OrigenCharacter> createState() => _OrigenCharacterState();
}

class _OrigenCharacterState extends State<OrigenCharacter> {

  late Future<Origen> origen;

  @override
  void initState() {
    super.initState();
    origen =  widget.charactersProvider.getOrigenFromCharacter(widget.character.origin.url);
  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder<Origen>(
      future: origen,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          var origen = snapshot.data!;

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('INFORMACION DEL PLANETA',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
              ),
              TableInformationOrigin(origen: origen),
              const SizedBox(height: 18,),
              const Text('FECHAD DE CREACION',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
                const SizedBox(height: 18,),
                Text(origen.created.toString(), style: const TextStyle(fontSize: 18),),
                const SizedBox(height: 150,)
            ],
          );

        }else if(snapshot.hasError){

          return ErrorMessageOrigin(error: snapshot.error);
        }
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}

class ErrorMessageOrigin extends StatelessWidget {

  final Object? error;

  const ErrorMessageOrigin({
    Key? key,
    required this.error
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(error.toString(), style: const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold),),
    );
  }
}

class TableInformationOrigin extends StatelessWidget {
  const TableInformationOrigin({
    Key? key,
    required this.origen,
  }) : super(key: key);

  final Origen origen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Table(
        border: TableBorder.all(),
        children: [
          buildRow(['NOMBRE', (origen.name)]),
          buildRow(['TIPO', (origen.type)]),
          buildRow(['DIMENSION', (origen.dimension)]),
        ],
      ),
    );
  }
}

TableRow buildRow(List<String> cells){

  return TableRow(
    children: cells.map((cell){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(cell, style: const TextStyle(fontSize: 18, letterSpacing: 1),)),
      );
    }).toList()
  );

}


class PosterAndInformationGeneral extends StatelessWidget {

  final Character character;

  const PosterAndInformationGeneral({
    Key? key,
    required this.character
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      height: 190,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            PosterDetail(character: character),
            DescriptionCharacter(character: character)
          ],
        ),
      ),
    );
  }
}

class DescriptionCharacter extends StatelessWidget {

  final Character character;

  const DescriptionCharacter({
    Key? key,
    required this.character
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyleName = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    const textStyleTitleDescription = TextStyle(fontSize: 16, letterSpacing: 1);

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 18),
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(character.name, style: textStyleName,),
              const Divider(thickness: 2),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('ESTADO : ', style: textStyleTitleDescription),
                  UtilApp.widgetStatusChatacter(character.status)
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('GENERO : ', style: textStyleTitleDescription),
                  Text(UtilApp.getGenderCharacter(character.gender), style: const TextStyle(color: Colors.black54, fontSize: 16))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('ESPECIE : ', style: textStyleTitleDescription),
                  Text(UtilApp.getSpecieCharacter(character.species), style: const TextStyle(color: Colors.black54, fontSize: 16))
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}




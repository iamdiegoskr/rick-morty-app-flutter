
import 'package:aplicacion_rick_morty_rest/models/character.dart';
import 'package:aplicacion_rick_morty_rest/services/character_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CharactersSearchDelegate extends SearchDelegate{

  @override
  String? get searchFieldLabel => 'Buscar personaje';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: ()=> query = '',
        icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          //Navigator.pop(context)
          close(context, null); //Podemos pasar un valor y obtenerlo luego.
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Se ejecuta cada que el input cambia.

    if(query.isEmpty){
      return const Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 65),
      );
    }

    final CharactersProvider charactersProvider = Provider.of<CharactersProvider>(context);



    return FutureBuilder(
      future: charactersProvider.getChatacterByQuery(query),
      builder: ((context, AsyncSnapshot<List<Character>> snapshot){

        if(snapshot.hasData){

          var listcharacters = snapshot.data ?? [];

          if(listcharacters.isEmpty){
            return const Center(
              child: Text('No hay personajes con esa busqueda'),
            );
          }

          return ListView.builder(
            itemCount: listcharacters.length,
            itemBuilder: (context, index){

              return Container(
                  margin: const EdgeInsets.all(14.0),
                  height: 120,
                  width: double.infinity,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: SizedBox(
                          width: 110,
                          height: double.infinity,
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder:  const AssetImage('assets/loadingicon.gif'),
                            image:  NetworkImage(listcharacters[index].image ?? 'https://via.placeholder.com/300x400'),
                        ),
                      )),
                      Container(
                        margin:  const EdgeInsets.only(left: 20),
                        child: Text(listcharacters[index].name,
                          style: GoogleFonts.zenLoop(fontSize: 28, fontWeight: FontWeight.bold)),
                      )
                    ]
                  ),
                );


            });
        }else if(snapshot.hasError){
          return const Center(
            child: Text('Error inesperado', style: TextStyle(color: Colors.red),),
          );
        }

        return const Center(child: CircularProgressIndicator());

      })
    );

  }



}
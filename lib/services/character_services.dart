

import 'package:aplicacion_rick_morty_rest/models/character.dart';
import 'package:aplicacion_rick_morty_rest/models/characters_response.dart';
import 'package:aplicacion_rick_morty_rest/models/origen.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class CharactersProvider extends ChangeNotifier {

  String baseUrl = 'rickandmortyapi.com';

  List<Character> myCharacters = [];
  int _currentPage = 0;

  CharactersProvider(){
    getCharacters();
  }

  Future<String> _getJsonData(String endpoint, [int page=1] ) async {
      var url = Uri.https(baseUrl, endpoint, {
        'page': '$page'
        }
      );
      var response = await http.get(url);
      return response.body;
  }


  getCharacters() async{
    _currentPage++;

    final responseData = await _getJsonData('api/character', _currentPage);
    final characteresResponse = CharactersResponse.fromJson(responseData);

    myCharacters = [...myCharacters, ...characteresResponse.results];

    notifyListeners();
  }


  Future<Origen> getOrigenFromCharacter(String url) async{

    if(url.isNotEmpty){
        var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {

        var origen = Origen.fromJson(response.body);
        return origen;

      } else {
        throw Exception('Failed to load origen');
      }
    }else{
      throw Exception('El origen del personaje es desconocido');
    }

  }

}
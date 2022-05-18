import 'dart:convert';

class Origen {
    Origen({
        required this.id,
        required this.name,
        required this.type,
        required this.dimension,
        this.residents,
        required this.url,
        required this.created,
    });

    int id;
    String name;
    String type;
    String dimension;
    List<String>? residents;
    String url;
    DateTime created;

    factory Origen.fromJson(String str) => Origen.fromMap(json.decode(str));

    factory Origen.fromMap(Map<String, dynamic> json) => Origen(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: json["residents"] == null ? [] : List<String>.from(json["residents"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
    );

}

// To parse this JSON data, do
//
//     final listServiceNurse = listServiceNurseFromJson(jsonString);

import 'dart:convert';

ListServiceNurse listServiceNurseFromJson(String str) => ListServiceNurse.fromJson(json.decode(str));

String listServiceNurseToJson(ListServiceNurse data) => json.encode(data.toJson());

class ListServiceNurse {
    int id;
    String name;
    String image;
    int sequence;
    String description;
    dynamic createdAt;
    dynamic updatedAt;
    dynamic deletedAt;

    ListServiceNurse({
        required this.id,
        required this.name,
        required this.image,
        required this.sequence,
        required this.description,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory ListServiceNurse.fromJson(Map<String, dynamic> json) => ListServiceNurse(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        sequence: json["sequence"],
        description: json["description"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "sequence": sequence,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
    };
}

// To parse this JSON data, do
//
//     final words = wordsFromJson(jsonString);

import 'dart:convert';

List<Words> wordsFromJson(String str) =>
    List<Words>.from(json.decode(str).map((x) => Words.fromJson(x)));

String wordsToJson(List<Words> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Words {
  List<String> words;

  Words({
    required this.words,
  });

  factory Words.fromJson(Map<String, dynamic> json) => Words(
        words: List<String>.from(json["words"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "words": List<dynamic>.from(words.map((x) => x)),
      };
}

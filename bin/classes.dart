import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';

part 'classes.g.dart';

enum Tag {
  english,
  ballads,
  children,
  scouty,
  hitoric,
  carols,
  folk,
  love,
  patriotic,
  insurgent,
  poetry,
  popular,
  reflective,
  religious,
  calm,
  shanty,
  travelling,
  fairyTales,
  lively
}

@JsonSerializable()
class Chord {
  String name;

  Chord(this.name);

  factory Chord.fromJson(Map<String, dynamic> json) => _$ChordFromJson(json);
  Map<String, dynamic> toJson() => _$ChordToJson(this);
}

@JsonSerializable()
class Line {
  String text;
  List<Chord> chords;

  Line(this.text, this.chords);

  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);
  Map<String, dynamic> toJson() => _$LineToJson(this);
}

@JsonSerializable()
class Stanza {
  List<Line> lines = [];
  int indention;

  Stanza(this.lines, {this.indention = 0});

  factory Stanza.fromJson(Map<String, dynamic> json, {double ver = 3.0}) {
    if (ver < 2.0) {
      throw Exception("Versions lower than 2.0 are not supported");
    }

    if (ver >= 3.0) {
      return _$StanzaFromJson(json);
    }

    if (ver >= 2.0) {
      List<String> texts = (json["text"] as String).split("\n");
      List<String> chords = (json["chords"] as String).split("\n");
      List<Line> lines = [];
      for (var i = 0; i < texts.length; i++) {
        List<Chord> cordsInLine = [];
        for (var chord in chords[i].split(" ")) {
          cordsInLine.add(Chord(chord));
        }
        lines.add(Line(texts[i], cordsInLine));
      }
      return Stanza(lines, indention: (json["shift"] as bool) ? 1 : 0);
    }

    throw Error();
  }
  Map<String, dynamic> toJson() => _$StanzaToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Song {
  final double ver;
  final String id;

  Set<String> titles = {};
  Set<String> authors = {};
  Set<String> performers = {};

  Set<String> ytLinks = {};

  Set<String> contributors = {};
  Set<Tag> tags = {};
  Set<Stanza> stanzas = {};

  Song(this.id,
      {this.ver = 3.0,
      this.titles = const {},
      this.authors = const {},
      this.contributors = const {},
      this.performers = const {},
      this.stanzas = const {},
      this.tags = const {},
      this.ytLinks = const {}});

  factory Song.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    double? ver = (json['ver'] as num?)?.toDouble();
    if (ver == null || ver < 2.0) {
      throw Exception("Versions lower than 2.0 are not supported");
    }

    if (ver >= 3.0) {
      return _$SongFromJson(json);
    }

    if (ver >= 2.0) {
      List<dynamic> titles = json['hid_titles'] as List<dynamic>;
      titles.insert(0, json['title']);
      List<dynamic> authors = json['text_authors'] as List<dynamic>;
      authors.addAll(json['composers'] as List<dynamic>);

      List<dynamic> stanzas = json['parts'] as List<dynamic>;
      stanzas.add(json['refren']);

      const Map<Tag, String> _enumDict = {
        Tag.english: "#Angielski",
        Tag.ballads: "#Ballady",
        Tag.children: "#DlaDzieci",
        Tag.scouty: "#Harcerskie",
        Tag.hitoric: "#Historyczne",
        Tag.carols: "#Kolędy",
        Tag.folk: "#Ludowe",
        Tag.love: "#OMiłości",
        Tag.patriotic: "#Patriotyczne",
        Tag.poetry: "#PoezjaŚpiewana",
        Tag.popular: "#Popularne",
        Tag.insurgent: "#Powstańcze",
        Tag.reflective: "#Refleksyjne",
        Tag.religious: "#Religijne",
        Tag.calm: "#Spokojne",
        Tag.shanty: "#Szanty",
        Tag.travelling: "#Turystyczne",
        Tag.fairyTales: "#ZBajek",
        Tag.lively: "#Żywe"
      };

      return Song(json['title'] as String)
        ..titles = titles.map((e) => e as String).toSet()
        ..authors = authors.map((e) => e as String).toSet()
        ..performers = (json['performers'] as List<dynamic>)
            .map((e) => e as String)
            .toSet()
        ..ytLinks = {json['yt_link'] as String}
        ..contributors =
            (json['add_pers'] as List<dynamic>).map((e) => e as String).toSet()
        ..tags = (json['tags'] as List<dynamic>)
            .map((e) => $enumDecode(_enumDict, e))
            .toSet()
        ..stanzas = stanzas
            .map((e) => Stanza.fromJson(e as Map<String, dynamic>, ver: ver))
            .toSet();
    }

    throw Error();
  }
  Map<String, dynamic> toJson() => _$SongToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chord _$ChordFromJson(Map<String, dynamic> json) => Chord(
      json['name'] as String,
    );

Map<String, dynamic> _$ChordToJson(Chord instance) => <String, dynamic>{
      'name': instance.name,
    };

Line _$LineFromJson(Map<String, dynamic> json) => Line(
      json['text'] as String,
      (json['chords'] as List<dynamic>)
          .map((e) => Chord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LineToJson(Line instance) => <String, dynamic>{
      'text': instance.text,
      'chords': instance.chords,
    };

Stanza _$StanzaFromJson(Map<String, dynamic> json) => Stanza(
      (json['lines'] as List<dynamic>)
          .map((e) => Line.fromJson(e as Map<String, dynamic>))
          .toList(),
      indention: json['indention'] as int? ?? 0,
    );

Map<String, dynamic> _$StanzaToJson(Stanza instance) => <String, dynamic>{
      'lines': instance.lines,
      'indention': instance.indention,
    };

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      json['id'] as String,
      ver: (json['ver'] as num?)?.toDouble() ?? 3.0,
      titles:
          (json['titles'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
              const {},
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      contributors: (json['contributors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      performers: (json['performers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      stanzas: (json['stanzas'] as List<dynamic>?)
              ?.map((e) => Stanza.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$TagEnumMap, e))
              .toSet() ??
          const {},
      ytLinks: (json['yt_links'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'ver': instance.ver,
      'id': instance.id,
      'titles': instance.titles.toList(),
      'authors': instance.authors.toList(),
      'performers': instance.performers.toList(),
      'yt_links': instance.ytLinks.toList(),
      'contributors': instance.contributors.toList(),
      'tags': instance.tags.map((e) => _$TagEnumMap[e]).toList(),
      'stanzas': instance.stanzas.toList(),
    };

const _$TagEnumMap = {
  Tag.english: 'english',
  Tag.ballads: 'ballads',
  Tag.children: 'children',
  Tag.scouty: 'scouty',
  Tag.hitoric: 'hitoric',
  Tag.carols: 'carols',
  Tag.folk: 'folk',
  Tag.love: 'love',
  Tag.patriotic: 'patriotic',
  Tag.insurgent: 'insurgent',
  Tag.poetry: 'poetry',
  Tag.popular: 'popular',
  Tag.reflective: 'reflective',
  Tag.religious: 'religious',
  Tag.calm: 'calm',
  Tag.shanty: 'shanty',
  Tag.travelling: 'travelling',
  Tag.fairyTales: 'fairyTales',
  Tag.lively: 'lively',
};

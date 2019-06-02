// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magDetailChild.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagDetailChild _$MagDetailChildFromJson(Map<String, dynamic> json) {
  return MagDetailChild()
    ..url = json['url'] as String
    ..title = json['title'] as String
    ..meta = json['meta'] as String
    ..type = json['type'] as num;
}

Map<String, dynamic> _$MagDetailChildToJson(MagDetailChild instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'meta': instance.meta,
      'type': instance.type
    };

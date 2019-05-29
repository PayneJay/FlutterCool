// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Site _$SiteFromJson(Map<String, dynamic> json) {
  return Site()
    ..id = json['id'] as String
    ..followed = json['followed'] as bool
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..lang = json['lang'] as num
    ..st = json['st'] as num
    ..cover = json['cover'] as String;
}

Map<String, dynamic> _$SiteToJson(Site instance) => <String, dynamic>{
      'id': instance.id,
      'followed': instance.followed,
      'name': instance.name,
      'image': instance.image,
      'lang': instance.lang,
      'st': instance.st,
      'cover': instance.cover
    };

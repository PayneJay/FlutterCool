// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'siteChild.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteChild _$SiteChildFromJson(Map<String, dynamic> json) {
  return SiteChild()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..cnt = json['cnt'] as num
    ..followed = json['followed'] as bool
    ..time = json['time'] as num;
}

Map<String, dynamic> _$SiteChildToJson(SiteChild instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'cnt': instance.cnt,
      'followed': instance.followed,
      'time': instance.time
    };

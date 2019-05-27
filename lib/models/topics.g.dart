// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topics _$TopicsFromJson(Map<String, dynamic> json) {
  return Topics()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..followed = json['followed'] as bool;
}

Map<String, dynamic> _$TopicsToJson(Topics instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'followed': instance.followed
    };

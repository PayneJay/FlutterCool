// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topicChild.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicChild _$TopicChildFromJson(Map<String, dynamic> json) {
  return TopicChild()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..upTime = json['upTime'] as num
    ..cnt = json['cnt'] as num
    ..image = json['image'] as String
    ..followed = json['followed'] as bool;
}

Map<String, dynamic> _$TopicChildToJson(TopicChild instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'upTime': instance.upTime,
      'cnt': instance.cnt,
      'image': instance.image,
      'followed': instance.followed
    };

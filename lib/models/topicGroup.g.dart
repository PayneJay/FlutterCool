// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topicGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicGroup _$TopicGroupFromJson(Map<String, dynamic> json) {
  return TopicGroup()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : TopicChild.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TopicGroupToJson(TopicGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'items': instance.items
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topicDirs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicDirs _$TopicDirsFromJson(Map<String, dynamic> json) {
  return TopicDirs()
    ..success = json['success'] as bool
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : TopicGroup.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TopicDirsToJson(TopicDirs instance) =>
    <String, dynamic>{'success': instance.success, 'items': instance.items};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topicSearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicSearch _$TopicSearchFromJson(Map<String, dynamic> json) {
  return TopicSearch()
    ..success = json['success'] as bool
    ..topics = (json['topics'] as List)
        ?.map((e) =>
            e == null ? null : TopicChild.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TopicSearchToJson(TopicSearch instance) =>
    <String, dynamic>{'success': instance.success, 'topics': instance.topics};

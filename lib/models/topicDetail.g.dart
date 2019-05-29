// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topicDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicDetail _$TopicDetailFromJson(Map<String, dynamic> json) {
  return TopicDetail()
    ..success = json['success'] as bool
    ..articles = (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : Articles.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..followed = json['followed'] as bool
    ..has_next = json['has_next'] as bool
    ..st = json['st'] as num
    ..lang = json['lang'] as num
    ..pn = json['pn'] as num
    ..image = json['image'] as String
    ..id = json['id'] as num
    ..name = json['name'] as String;
}

Map<String, dynamic> _$TopicDetailToJson(TopicDetail instance) =>
    <String, dynamic>{
      'success': instance.success,
      'articles': instance.articles,
      'followed': instance.followed,
      'has_next': instance.has_next,
      'st': instance.st,
      'lang': instance.lang,
      'pn': instance.pn,
      'image': instance.image,
      'id': instance.id,
      'name': instance.name
    };

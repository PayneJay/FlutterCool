// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..time = json['time'] as String
    ..feed_title = json['feed_title'] as String
    ..url = json['url'] as String
    ..content = json['content'] as String
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : Images.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..cmt = json['cmt'] as num
    ..lang = json['lang'] as num
    ..img = json['img'] as String
    ..topics = (json['topics'] as List)
        ?.map((e) =>
            e == null ? null : TopicChild.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'time': instance.time,
      'feed_title': instance.feed_title,
      'url': instance.url,
      'content': instance.content,
      'images': instance.images,
      'cmt': instance.cmt,
      'lang': instance.lang,
      'img': instance.img,
      'topics': instance.topics
    };

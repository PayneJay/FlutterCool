// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Articles _$ArticlesFromJson(Map<String, dynamic> json) {
  return Articles()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..time = json['time'] as String
    ..rectime = json['rectime'] as String
    ..uts = json['uts'] as num
    ..feed_title = json['feed_title'] as String
    ..img = json['img'] as String
    ..abs = json['abs'] as String
    ..cmt = json['cmt'] as num
    ..st = json['st'] as num
    ..go = json['go'] as num;
}

Map<String, dynamic> _$ArticlesToJson(Articles instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'time': instance.time,
      'rectime': instance.rectime,
      'uts': instance.uts,
      'feed_title': instance.feed_title,
      'img': instance.img,
      'abs': instance.abs,
      'cmt': instance.cmt,
      'st': instance.st,
      'go': instance.go
    };

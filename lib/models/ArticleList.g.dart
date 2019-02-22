// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleList _$ArticleListFromJson(Map<String, dynamic> json) {
  return ArticleList(
      json['success'] as bool,
      json['has_next'] as bool,
      (json['articles'] as List)
          ?.map((e) =>
              e == null ? null : Article.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['lang'] as int,
      json['pn'] as int,
      json['cats'] == null
          ? null
          : Cat.fromJson(json['cats'] as Map<String, dynamic>),
      json['cid'] as int);
}

Map<String, dynamic> _$ArticleListToJson(ArticleList instance) =>
    <String, dynamic>{
      'success': instance.success,
      'has_next': instance.has_next,
      'articles': instance.articles,
      'lang': instance.lang,
      'pn': instance.pn,
      'cats': instance.cats,
      'cid': instance.cid
    };

Cat _$CatFromJson(Map<String, dynamic> json) {
  return Cat(json['id'] as int, json['desc'] as String, json['seo'] as String);
}

Map<String, dynamic> _$CatToJson(Cat instance) => <String, dynamic>{
      'id': instance.id,
      'desc': instance.desc,
      'seo': instance.seo
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
      json['id'] as String,
      json['title'] as String,
      json['time'] as String,
      json['rectime'] as String,
      json['uts'],
      json['feed_title'] as String,
      json['img'] as String,
      json['abs'] as String,
      json['cmt'] as int,
      json['st'] as int,
      json['go'] as int);
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
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

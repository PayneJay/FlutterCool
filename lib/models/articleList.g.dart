// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articleList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleList _$ArticleListFromJson(Map<String, dynamic> json) {
  return ArticleList()
    ..success = json['success'] as bool
    ..has_next = json['has_next'] as bool
    ..articles = (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : Articles.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..lang = json['lang'] as num
    ..pn = json['pn'] as num
    ..cats = json['cats'] == null
        ? null
        : Cat.fromJson(json['cats'] as Map<String, dynamic>)
    ..cid = json['cid'] as num;
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

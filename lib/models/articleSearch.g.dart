// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articleSearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleSearch _$ArticleSearchFromJson(Map<String, dynamic> json) {
  return ArticleSearch()
    ..success = json['success'] as bool
    ..articles = (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : Articles.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..pn = json['pn'] as num
    ..limit = json['limit'] as num
    ..lang = json['lang'] as num
    ..total = json['total'] as num
    ..has_next = json['has_next'] as bool;
}

Map<String, dynamic> _$ArticleSearchToJson(ArticleSearch instance) =>
    <String, dynamic>{
      'success': instance.success,
      'articles': instance.articles,
      'pn': instance.pn,
      'limit': instance.limit,
      'lang': instance.lang,
      'total': instance.total,
      'has_next': instance.has_next
    };

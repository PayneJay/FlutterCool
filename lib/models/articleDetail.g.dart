// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articleDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetail _$ArticleDetailFromJson(Map<String, dynamic> json) {
  return ArticleDetail()
    ..success = json['success'] as bool
    ..article = json['article'] == null
        ? null
        : Article.fromJson(json['article'] as Map<String, dynamic>)
    ..like = json['like'] as String
    ..site = json['site'] as Map<String, dynamic>;
}

Map<String, dynamic> _$ArticleDetailToJson(ArticleDetail instance) =>
    <String, dynamic>{
      'success': instance.success,
      'article': instance.article,
      'like': instance.like,
      'site': instance.site
    };

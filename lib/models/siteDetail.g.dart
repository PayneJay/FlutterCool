// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'siteDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteDetail _$SiteDetailFromJson(Map<String, dynamic> json) {
  return SiteDetail()
    ..success = json['success'] as bool
    ..articles = (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : Articles.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..site = json['site'] == null
        ? null
        : Site.fromJson(json['site'] as Map<String, dynamic>)
    ..has_next = json['has_next'] as bool;
}

Map<String, dynamic> _$SiteDetailToJson(SiteDetail instance) =>
    <String, dynamic>{
      'success': instance.success,
      'articles': instance.articles,
      'site': instance.site,
      'has_next': instance.has_next
    };

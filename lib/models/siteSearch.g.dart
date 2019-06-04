// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'siteSearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteSearch _$SiteSearchFromJson(Map<String, dynamic> json) {
  return SiteSearch()
    ..success = json['success'] as bool
    ..items = (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Site.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SiteSearchToJson(SiteSearch instance) =>
    <String, dynamic>{'success': instance.success, 'items': instance.items};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'siteDirs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteDirs _$SiteDirsFromJson(Map<String, dynamic> json) {
  return SiteDirs()
    ..success = json['success'] as bool
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : SiteGroup.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SiteDirsToJson(SiteDirs instance) =>
    <String, dynamic>{'success': instance.success, 'items': instance.items};

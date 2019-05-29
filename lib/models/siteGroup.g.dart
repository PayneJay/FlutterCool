// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'siteGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteGroup _$SiteGroupFromJson(Map<String, dynamic> json) {
  return SiteGroup()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : SiteChild.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SiteGroupToJson(SiteGroup instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'items': instance.items
    };

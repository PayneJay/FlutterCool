// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagGroup _$MagGroupFromJson(Map<String, dynamic> json) {
  return MagGroup()
    ..name = json['name'] as String
    ..type = json['type'] as num
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : MagChild.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MagGroupToJson(MagGroup instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'items': instance.items
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magDetailGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagDetailGroup _$MagDetailGroupFromJson(Map<String, dynamic> json) {
  return MagDetailGroup()
    ..name = json['name'] as String
    ..items = (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : MagDetailChild.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MagDetailGroupToJson(MagDetailGroup instance) =>
    <String, dynamic>{'name': instance.name, 'items': instance.items};

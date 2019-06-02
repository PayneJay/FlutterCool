// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagDetail _$MagDetailFromJson(Map<String, dynamic> json) {
  return MagDetail()
    ..success = json['success'] as bool
    ..items = (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : MagDetailGroup.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MagDetailToJson(MagDetail instance) =>
    <String, dynamic>{'success': instance.success, 'items': instance.items};

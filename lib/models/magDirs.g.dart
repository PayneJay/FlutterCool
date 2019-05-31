// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magDirs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagDirs _$MagDirsFromJson(Map<String, dynamic> json) {
  return MagDirs()
    ..success = json['success'] as bool
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : MagGroup.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MagDirsToJson(MagDirs instance) =>
    <String, dynamic>{'success': instance.success, 'items': instance.items};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookDirs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookDirs _$BookDirsFromJson(Map<String, dynamic> json) {
  return BookDirs()
    ..success = json['success'] as bool
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : BookGroup.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BookDirsToJson(BookDirs instance) =>
    <String, dynamic>{'success': instance.success, 'items': instance.items};

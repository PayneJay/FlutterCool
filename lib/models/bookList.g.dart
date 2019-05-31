// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookList _$BookListFromJson(Map<String, dynamic> json) {
  return BookList()
    ..success = json['success'] as bool
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : BookChild.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..has_next = json['has_next'] as bool;
}

Map<String, dynamic> _$BookListToJson(BookList instance) => <String, dynamic>{
      'success': instance.success,
      'items': instance.items,
      'has_next': instance.has_next
    };

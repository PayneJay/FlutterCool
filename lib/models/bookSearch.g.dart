// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookSearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookSearch _$BookSearchFromJson(Map<String, dynamic> json) {
  return BookSearch()
    ..success = json['success'] as bool
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : BookChild.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..has_next = json['has_next'] as bool;
}

Map<String, dynamic> _$BookSearchToJson(BookSearch instance) =>
    <String, dynamic>{
      'success': instance.success,
      'items': instance.items,
      'has_next': instance.has_next
    };

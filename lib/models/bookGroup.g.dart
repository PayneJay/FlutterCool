// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookGroup _$BookGroupFromJson(Map<String, dynamic> json) {
  return BookGroup()
    ..books = (json['books'] as List)
        ?.map((e) =>
            e == null ? null : BookChild.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..tagId = json['tagId'] as num
    ..tagName = json['tagName'] as String;
}

Map<String, dynamic> _$BookGroupToJson(BookGroup instance) => <String, dynamic>{
      'books': instance.books,
      'tagId': instance.tagId,
      'tagName': instance.tagName
    };

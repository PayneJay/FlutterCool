// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookChild.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookChild _$BookChildFromJson(Map<String, dynamic> json) {
  return BookChild()
    ..id = json['id'] as String
    ..link = json['link'] as String
    ..title = json['title'] as String
    ..thumb = json['thumb'] as String
    ..author = json['author'] as String
    ..price = json['price'] as num
    ..pubTime = json['pubTime'] as num;
}

Map<String, dynamic> _$BookChildToJson(BookChild instance) => <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'title': instance.title,
      'thumb': instance.thumb,
      'author': instance.author,
      'price': instance.price,
      'pubTime': instance.pubTime
    };

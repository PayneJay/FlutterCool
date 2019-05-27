// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return Images()
    ..id = json['id'] as String
    ..w = json['w'] as num
    ..h = json['h'] as num
    ..src = json['src'] as String;
}

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'id': instance.id,
      'w': instance.w,
      'h': instance.h,
      'src': instance.src
    };

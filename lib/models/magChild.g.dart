// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magChild.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagChild _$MagChildFromJson(Map<String, dynamic> json) {
  return MagChild()
    ..id = json['id'] as String
    ..type = json['type'] as num
    ..title = json['title'] as String
    ..time = json['time'] as num;
}

Map<String, dynamic> _$MagChildToJson(MagChild instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'time': instance.time
    };

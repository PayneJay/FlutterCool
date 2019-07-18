// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as num
    ..email = json['email'] as String
    ..name = json['name'] as String
    ..ctime = json['ctime'] as num
    ..uid = json['uid'] as String
    ..profile = json['profile'] as String
    ..token = json['token'] as String
    ..notification_num = json['notification_num'] as num
    ..weibo_id = json['weibo_id'] as num
    ..weibo_name = json['weibo_name'] as String
    ..qq_id = json['qq_id'] as String
    ..qq_name = json['qq_name'] as String
    ..weixin_name = json['weixin_name'] as String
    ..flyme_name = json['flyme_name'] as String
    ..is_new = json['is_new'] as bool;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'ctime': instance.ctime,
      'uid': instance.uid,
      'profile': instance.profile,
      'token': instance.token,
      'notification_num': instance.notification_num,
      'weibo_id': instance.weibo_id,
      'weibo_name': instance.weibo_name,
      'qq_id': instance.qq_id,
      'qq_name': instance.qq_name,
      'weixin_name': instance.weixin_name,
      'flyme_name': instance.flyme_name,
      'is_new': instance.is_new
    };

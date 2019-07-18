import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    num id;
    String email;
    String name;
    num ctime;
    String uid;
    String profile;
    String token;
    num notification_num;
    num weibo_id;
    String weibo_name;
    String qq_id;
    String qq_name;
    String weixin_name;
    String flyme_name;
    bool is_new;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}

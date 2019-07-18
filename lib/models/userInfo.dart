import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'userInfo.g.dart';

@JsonSerializable()
class UserInfo {
    UserInfo();

    bool success;
    String error;
    User user;
    String auditing_version;
    
    factory UserInfo.fromJson(Map<String,dynamic> json) => _$UserInfoFromJson(json);
    Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

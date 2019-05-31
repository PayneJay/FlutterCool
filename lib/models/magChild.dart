import 'package:json_annotation/json_annotation.dart';

part 'magChild.g.dart';

@JsonSerializable()
class MagChild {
    MagChild();

    String id;
    num type;
    String title;
    num time;
    
    factory MagChild.fromJson(Map<String,dynamic> json) => _$MagChildFromJson(json);
    Map<String, dynamic> toJson() => _$MagChildToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'topics.g.dart';

@JsonSerializable()
class Topics {
    Topics();

    num id;
    String name;
    String image;
    bool followed;
    
    factory Topics.fromJson(Map<String,dynamic> json) => _$TopicsFromJson(json);
    Map<String, dynamic> toJson() => _$TopicsToJson(this);
}

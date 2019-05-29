import 'package:json_annotation/json_annotation.dart';

part 'topicChild.g.dart';

@JsonSerializable()
class TopicChild {
    TopicChild();

    num id;
    String name;
    num upTime;
    num cnt;
    String image;
    bool followed;
    
    factory TopicChild.fromJson(Map<String,dynamic> json) => _$TopicChildFromJson(json);
    Map<String, dynamic> toJson() => _$TopicChildToJson(this);
}

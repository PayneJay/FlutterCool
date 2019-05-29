import 'package:json_annotation/json_annotation.dart';
import "topicChild.dart";
part 'topicGroup.g.dart';

@JsonSerializable()
class TopicGroup {
    TopicGroup();

    num id;
    String name;
    List<TopicChild> items;
    
    factory TopicGroup.fromJson(Map<String,dynamic> json) => _$TopicGroupFromJson(json);
    Map<String, dynamic> toJson() => _$TopicGroupToJson(this);
}

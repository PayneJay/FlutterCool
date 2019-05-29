import 'package:json_annotation/json_annotation.dart';
import "articles.dart";
part 'topicDetail.g.dart';

@JsonSerializable()
class TopicDetail {
    TopicDetail();

    bool success;
    List<Articles> articles;
    bool followed;
    bool has_next;
    num st;
    num lang;
    num pn;
    String image;
    num id;
    String name;
    
    factory TopicDetail.fromJson(Map<String,dynamic> json) => _$TopicDetailFromJson(json);
    Map<String, dynamic> toJson() => _$TopicDetailToJson(this);
}

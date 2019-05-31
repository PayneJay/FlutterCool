import 'package:json_annotation/json_annotation.dart';
import "images.dart";
import "topicChild.dart";
part 'article.g.dart';

@JsonSerializable()
class Article {
    Article();

    String id;
    String title;
    String time;
    String feed_title;
    String url;
    String content;
    List<Images> images;
    num cmt;
    num lang;
    String img;
    List<TopicChild> topics;
    
    factory Article.fromJson(Map<String,dynamic> json) => _$ArticleFromJson(json);
    Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

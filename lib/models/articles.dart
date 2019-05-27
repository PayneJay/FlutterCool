import 'package:json_annotation/json_annotation.dart';

part 'articles.g.dart';

@JsonSerializable()
class Articles {
    Articles();

    String id;
    String title;
    String time;
    String rectime;
    num uts;
    String feed_title;
    String img;
    String abs;
    num cmt;
    num st;
    num go;
    
    factory Articles.fromJson(Map<String,dynamic> json) => _$ArticlesFromJson(json);
    Map<String, dynamic> toJson() => _$ArticlesToJson(this);
}

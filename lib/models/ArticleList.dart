import 'package:json_annotation/json_annotation.dart';

part 'ArticleList.g.dart';

@JsonSerializable()
class ArticleList {
  bool success;
  bool has_next;
  List<Article> articles;
  int lang;
  int pn;
  Cat cats;
  int cid;

  ArticleList(this.success, this.has_next, this.articles, this.lang, this.pn,
      this.cats, this.cid);

  //反序列化
  factory ArticleList.fromJson(Map<String, dynamic> json) =>
      _$ArticleListFromJson(json);

  //序列化
  Map<String, dynamic> toJson() => _$ArticleListToJson(this);
}

@JsonSerializable()
class Cat {
  int id;
  String desc;
  String seo;

  Cat(this.id, this.desc, this.seo);

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

  Map<String, dynamic> toJson() => _$CatToJson(this);
}

@JsonSerializable()
class Article {
  String id;
  String title;
  String time;
  String rectime;
  var uts;
  String feed_title;
  String img;
  String abs;
  int cmt;
  int st;
  int go;

  Article(this.id, this.title, this.time, this.rectime, this.uts,
      this.feed_title, this.img, this.abs, this.cmt, this.st, this.go);

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';

@JsonSerializable()
class Cat {
    Cat();

    num id;
    String desc;
    String seo;
    List exclude;
    List include;
    
    factory Cat.fromJson(Map<String,dynamic> json) => _$CatFromJson(json);
    Map<String, dynamic> toJson() => _$CatToJson(this);
}

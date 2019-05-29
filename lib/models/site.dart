import 'package:json_annotation/json_annotation.dart';

part 'site.g.dart';

@JsonSerializable()
class Site {
    Site();

    String id;
    bool followed;
    String name;
    String image;
    num lang;
    num st;
    String cover;
    
    factory Site.fromJson(Map<String,dynamic> json) => _$SiteFromJson(json);
    Map<String, dynamic> toJson() => _$SiteToJson(this);
}

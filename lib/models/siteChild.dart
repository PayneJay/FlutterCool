import 'package:json_annotation/json_annotation.dart';

part 'siteChild.g.dart';

@JsonSerializable()
class SiteChild {
    SiteChild();

    String id;
    String name;
    String image;
    num cnt;
    bool followed;
    num time;
    
    factory SiteChild.fromJson(Map<String,dynamic> json) => _$SiteChildFromJson(json);
    Map<String, dynamic> toJson() => _$SiteChildToJson(this);
}

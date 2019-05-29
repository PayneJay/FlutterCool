import 'package:json_annotation/json_annotation.dart';
import "siteChild.dart";
part 'siteGroup.g.dart';

@JsonSerializable()
class SiteGroup {
    SiteGroup();

    num id;
    String name;
    List<SiteChild> items;
    
    factory SiteGroup.fromJson(Map<String,dynamic> json) => _$SiteGroupFromJson(json);
    Map<String, dynamic> toJson() => _$SiteGroupToJson(this);
}

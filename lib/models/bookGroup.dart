import 'package:json_annotation/json_annotation.dart';
import "bookChild.dart";
part 'bookGroup.g.dart';

@JsonSerializable()
class BookGroup {
    BookGroup();

    List<BookChild> books;
    num tagId;
    String tagName;
    
    factory BookGroup.fromJson(Map<String,dynamic> json) => _$BookGroupFromJson(json);
    Map<String, dynamic> toJson() => _$BookGroupToJson(this);
}

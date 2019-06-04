import 'package:json_annotation/json_annotation.dart';
import "bookChild.dart";
part 'bookSearch.g.dart';

@JsonSerializable()
class BookSearch {
    BookSearch();

    bool success;
    List<BookChild> items;
    bool has_next;
    
    factory BookSearch.fromJson(Map<String,dynamic> json) => _$BookSearchFromJson(json);
    Map<String, dynamic> toJson() => _$BookSearchToJson(this);
}

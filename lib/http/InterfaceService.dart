final articleListUrl = "/api/articles/hot.json";
final siteDirUrl = "/api/sites/my_with_dirs.json";
final topicDirUrl = "/api/topics/my_with_dirs.json";
final magazineUrl = "/api/mag/home.json";
final bookUrl = "/api/books.json";
final bookTagUrl = "/api/books/tag.json";
final periodListUrl = "/api/mag/period_list.json";
final magDetailUrl = "/api/mag/detail.json";
final articleSearchUrl = "/api/articles/search.json";
final topicSearchUrl = "/api/topics/search.json";
final siteSearchUrl = "/api/sites/search.json";
final bookSearchUrl = "/api/search/book.json";
final loginUrl = "/api/login.json";

String getArticleDetailUrl(String id) {
  return "/api/articles/$id.json";
}

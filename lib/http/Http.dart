import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

var dio = new Dio(new BaseOptions(
  baseUrl: "http://api.tuicool.com",
  connectTimeout: 10000,
  receiveTimeout: 30000,
  headers: _getHeaders(),
  contentType: "json",
  // Transform the response data to a String encoded with UTF8.
  // The default value is [ResponseType.JSON].
  responseType: ResponseType.json,
));

Map<String, String> _getHeaders() {
  final userName = '0.0.0.0';
  final passWord = 'tuicool';
  final preStr = '$userName:$passWord';
  final bytes = utf8.encode(preStr);
  // 要进行 Basic Auth 的话, 需要对用户名和密码进行 base64 编码计算.
  final base64Str = base64.encode(bytes);
  final headers = {
    'Accept': ' */*',
    'Accept-Language': 'zh-Hans-CN;q=1, en-CN;q=0.9, zh-Hant-CN;q=0.8',
    'Accept-Encoding': 'br, gzip, deflate',
    'Authorization': 'Basic $base64Str',
  };

  print(headers);
  return headers;
}

# 协议层移植约定（供并行开发使用）

## 目录与导入

- 生成的 protobuf 类统一从 `lib/protocol/generated/generated.dart` 以 `pb` 前缀导入。
- HTTP 核心：`lib/protocol/core/http_core.dart` 的 `TiebaHttpCore`。
- 异常：`lib/protocol/core/exceptions.dart` 的 `TiebaServerException` / `TiebaHttpException` / `TiebaFormatException` / `TiebaValueException`。
- JSON 错误检查：`lib/protocol/api/_common.dart` 的 `ensureJsonOk` / `ensureWebOk`。
- 页码/字符串解析：`lib/protocol/core/utils.dart` 的 `parseInt` / `parseString` / `normalizePortrait` / `checkRn`。
- 64 位字段用 `package:fixnum/fixnum.dart` 的 `Int64`；读取时用 `.toInt()`。

## HTTP 方法

```dart
Future<Uint8List> postProto(String path, int cmd, List<int> payload);
Future<Map<String, dynamic>> postForm(String path, List<MapEntry<String, String>> data, {String salt});
Future<TiebaHttpResponse> postFormResponse(String path, List<MapEntry<String, String>> data, {String salt});
Future<Map<String, dynamic>> webGetJson(String path, {Map<String, String>? query, String? referer});
Future<Uint8List> webGetBytes(String path, {Map<String, String>? query, String? referer});
Future<Map<String, dynamic>> webPostForm(String path, List<MapEntry<String, String>> data, {String? referer, Map<String, String>? extraHeaders, Map<String, String>? query});
Future<TiebaHttpResponse> postRaw(Uri uri, {required List<int> body, Map<String, String> headers, String? contentType});
Future<TiebaHttpResponse> getRaw(Uri uri, {Map<String, String> headers});
Future<Uint8List> fetchBytes(Uri uri, {String? referer});
```

- `postForm` 自动按 APP salt 签名；`postProto` 自动加 `x_bd_data_type: protobuf` 与 multipart boundary。
- 需要 Cookie/响应头时用 `postFormResponse` / `postRaw` / `getRaw`。
- 默认 app host 为 `tiebac.baidu.com`（HTTPS），web host 为 `tieba.baidu.com`。

## 代码风格

- 注释和标识符用英文；文档正文可中文。
- API 函数命名 `fetchXxx`，返回领域模型或 `Future<void>`；不要在这里做 UI 相关处理。
- 请求错误统一抛 `TiebaServerException`；HTTP 非 200 由 `TiebaHttpCore` 抛 `TiebaHttpException`。
- 写操作在函数内直接检查 `BDUSS/tbs`，缺凭证抛 `TiebaValueException`。
- 不要修改 `client.dart`、`tieba_protocol.dart`、`pubspec.yaml`、其他成员的既有文件；只新增自己 scope 内的文件。
- 每个新文件写完后运行：`dart analyze lib/protocol/api/<file>.dart lib/protocol/models/<file>.dart`。

## 参考

- 现有读接口示例：`lib/protocol/api/get_threads.dart`、`get_posts.dart`、`get_comments.dart`
- 现有写接口示例：`lib/protocol/api/write_ops.dart`
- 现有模型示例：`lib/protocol/models/thread.dart`、`post.dart`、`comment.dart`
- 原始 Python：`D:\any\aiotieba-ref\src\aiotieba\api\`（只读）

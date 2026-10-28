# Third-party notices

本项目（Feiba）使用或移植了以下第三方成果：

## aiotieba

- 项目：https://github.com/lumina37/aiotieba
- 版本：4.8.2
- 许可证：Unlicense（public domain）
- 使用方式：协议常量、HTTP 传输设计、protobuf schema（proto/ 目录）、设备 crypto 算法（cuid_galaxy2 / c3_aid）、部分接口语义与模型移植为 Dart。

## protobuf

- 项目：https://github.com/protocolbuffers/protobuf
- 许可证：BSD-3-Clause
- 使用方式：protoc 生成 Dart 代码；Dart 运行时为 pub.dev 的 protobuf 包。

## base32 / CRC32 / xxHash

- base32：Google，Apache-2.0
- CRC32：Wang Yaofu，Apache-2.0
- xxHash：Yann Collet，BSD-2-Clause
- 使用方式：算法语义参考并移植为 Dart（lib/protocol/core/crypto.dart）。

## material_ui

- 项目：https://pub.dev/packages/material_ui
- 许可证：BSD-3-Clause
- 使用方式：Flutter 3.47 后官方 Material UI 包；本项目用其 Material 组件、MaterialShapes、
  MaterialShapeBorder 和 M3 Expressive IconButton。

## webview_flutter_windows / WebView2

- 项目：https://github.com/omar-hanafy/webview_flutter_windows
- 许可证：BSD-3-Clause（基于 jnschulze/flutter-webview-windows）
- 使用方式：Windows 内置 WebView2 登录页；通过 WebView2 CookieManager 读取 HttpOnly 的 BDUSS/STOKEN。
- 运行时依赖：Microsoft Edge WebView2 Runtime（Windows 11 自带，Windows 10 可由系统安装）；WebView2 SDK 由 Microsoft 提供。

## flutter_staggered_grid_view

- 项目：https://pub.dev/packages/flutter_staggered_grid_view
- 许可证：MIT
- 使用方式：吧外帖子的瀑布流卡片布局。

## animations

- 项目：https://pub.dev/packages/animations
- 许可证：BSD-3-Clause（Flutter 官方 Material motion 示例包）
- 使用方式：帖子详情的 OpenContainer 卡片展开动画，以及非卡片入口的 Shared Axis 转场。

## Dart / Flutter 依赖

见 pubspec.yaml，各自遵循其 pub.dev 许可证。
## TiebaLite（仅设计参考，未包含代码或素材）

- 项目：https://github.com/HuanCheng65/TiebaLite
- 许可证：GPL-3.0
- 使用方式：本项目的 UI 布局、导航和信息层级参考其公开设计；未复制其 Kotlin 代码、图片、字体或 drawable。
  Feiba 当前使用 MIT 许可证，若未来直接使用其素材，需要先调整许可证或取得授权。
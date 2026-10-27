# Feiba

第三方百度贴吧客户端（非官方），使用 Flutter 构建，同时运行在 **Android** 与 **Windows** 桌面。

> 本项目与百度公司无关，仅供学习交流使用。请勿用于商业用途。

## 当前进度

| 阶段 | 内容 | 状态 |
| --- | --- | --- |
| P0 | 工程架构、Material 3 主题、路由 | 已完成 |
| P1 | 协议基座（aiotieba 移植）：三种传输、protobuf、账号 crypto、读写接口 | 已完成 |
| P2 | 只读主链路：吧页帖子列表 → 帖子详情 → 楼中楼 | 进行中 |
| P3 | 媒体：图片、WebView、视频 | 待开始 |
| P4 | 登录与多账号 | 待开始 |
| P5 | 写操作：发帖、回复、点赞、收藏 | 待开始 |
| P6 | 搜索、用户主页、收藏、历史、热搜 | 待开始 |
| P7 | 设置（主题、习惯、屏蔽、账号、关于） | 待开始 |
| P8 | Android 专属：签到、通知、快捷磁贴 | 待开始 |
| P9 | 桌面适配：窗口记忆、快捷键、右键菜单 | 待开始 |
| P10 | 打包发布：签名 APK、Windows MSI | 待开始 |

## 技术栈

| 用途 | 选型 |
| --- | --- |
| UI | Flutter 3.47+ / Material 3 |
| 网络 | dio |
| 协议签名 | crypto（MD5） |
| 富文本内容 | 自定义 `ContentView`（文本 / 表情 / 图片 / 话题链接） |

## 协议层（aiotieba 移植）

协议层位于 `lib/protocol/`，是 [aiotieba](https://github.com/lumina37/aiotieba)（Unlicense）4.8.2 的 Dart 移植：

- 三种传输：APP 表单签名、APP protobuf（`tiebac.baidu.com`）、WEB（`tieba.baidu.com`）
- 账号派生字段：android_id / uuid / cuid / cuid_galaxy2 / c3_aid / tbs
- 已覆盖 aiotieba 4.8.2 的全部 API 模块：吧/帖/楼中楼、搜索、用户/主页/历史、通知、吧务、恢复/申诉、排行、图片、全部读写操作，以及 BLCP/WebSocket 聊天/IM
- `proto/` 为移植的 protobuf schema，生成代码在 `lib/protocol/generated/`

> 当前 Flutter UI 仍使用旧的 `lib/core/tieba_client.dart` JSON 实现；协议层已全量移植，切换 UI 数据源是下一步。覆盖清单见 [docs/port-checklist.md](docs/port-checklist.md)，设计与验证边界见 [docs/aiotieba-port.md](docs/aiotieba-port.md)。

联调：

```bash
dart run tool/protocol_smoke.dart 原神
```

## 协议层说明

贴吧客户端接口需要 `sign` 参数，算法为：

```
sign = md5( 按字典序拼接的 "key=value" 串 + appSecret )
```

参数名与算法属于公开的逆向工程知识。协议层以 aiotieba（Unlicense）为参考移植为 Dart，第三方说明见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

## 构建

```bash
flutter pub get
flutter run -d windows    # Windows 桌面
flutter run -d <device>   # Android 真机
```

### 验证

```bash
flutter analyze           # 静态检查
flutter test              # 单元 + 组件测试
dart run tool/smoke.dart 原神          # 旧 JSON 链路联通性验证（需要网络）
dart run tool/protocol_smoke.dart 原神 # 新协议层联通性验证
dart run tool/compare_legacy.dart 原神 # 新旧实现对照
flutter build windows --debug       # 构建验证
```

## 许可证

MIT
# Feiba

第三方百度贴吧客户端（非官方），使用 Flutter 构建，同时运行在 **Android** 与 **Windows** 桌面。

> 本项目与百度公司无关，仅供学习交流使用。请勿用于商业用途。

## 当前进度

| 阶段 | 内容 | 状态 |
| --- | --- | --- |
| P0 | 工程架构、Material 3 主题、路由 | 已完成 |
| P1 | 协议基座：签名、公共参数、HTTP 客户端 | 已完成 |
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

## 协议层说明

贴吧客户端接口需要 `sign` 参数，算法为：

```
sign = md5( 按字典序拼接的 "key=value" 串 + appSecret )
```

参数名与算法属于公开的逆向工程知识，本项目以 Dart 从零实现，未复制任何第三方代码。

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
dart run tool/smoke.dart 原神   # 真实接口联通性验证（需要网络）
```

## 许可证

MIT

# Feiba

第三方百度贴吧客户端（非官方），使用 Flutter 构建，同时运行在 **Android** 与 **Windows** 桌面。

> 本项目与百度公司无关，仅供学习交流使用。请勿用于商业用途。

## 当前进度

| 阶段 | 内容 | 状态 |
| --- | --- | --- |
| P0 | 工程架构、Material 3 主题、路由 | 已完成 |
| P1 | 协议基座（aiotieba 移植）：三种传输、protobuf、账号 crypto、读写接口 | 已完成 |
| P2 | 只读主链路：吧页帖子列表 → 帖子详情 → 楼中楼 | 已完成（协议层 getThreads/getPosts） |
| P3 | 媒体：图片、WebView、视频 | 部分完成（图片查看/保存） |
| P4 | 登录与多账号 | 部分完成（Android/Windows 内置 WebView 自动提取 BDUSS；手动粘贴兜底；fetchLogin 校验） |
| P5 | 写操作：发帖、回复、点赞、收藏 | 待开始 |
| P6 | 搜索、用户主页、收藏、历史、热搜 | 部分完成（协议层搜索、关注的人/主页、话题榜/热吧/推荐、本地历史） |
| P7 | 设置（主题、习惯、屏蔽、账号、关于） | 部分完成（外观/缓存/关于/许可） |
| P8 | Android 专属：签到、通知、快捷磁贴 | 部分完成（吧签到、消息列表） |
| P9 | 桌面适配：窗口记忆、快捷键、右键菜单 | 待开始 |
| P10 | 打包发布：签名 APK、Windows MSI | 待开始 |

## 技术栈

| 用途 | 选型 |
| --- | --- |
| UI | Flutter 3.47+ / `material_ui` 1.8 / Material 3 + 官方 M3E 局部能力 |
| 网络 | dio |
| 协议签名 | crypto（MD5） |
| 富文本内容 | 自定义 `ContentView`（文本 / 表情 / 图片 / 话题链接） |

## UI 设计

界面采用四栏底部导航：**关注 / 广场 / 消息 / 我的**。

- 关注：横向四页 **动态 / 吧 / 吧友 / 看过**
  - 动态：关注的吧的最新帖子汇总；按真实发布时间排序
  - 吧：账号关注贴吧或本地关注；显示真实成员数、等级、今日热帖
  - 吧友：登录后展示关注的人，点击进入对方主页与最近发帖
  - 看过：本地浏览历史派生出的最近贴吧
- 广场：横向四页 **话题 / 推荐 / 热吧 / 热帖**
  - 话题：贴吧话题榜的真实排名、讨论数、话题图和描述
  - 推荐：按分类读取吧广场推荐吧，分类只保留接口有数据的项
  - 热吧：吧广场「热门」分类的真实热门吧及成员数
  - 热帖：从热吧前 3 个吧取真实热帖（getThreads sort=hot）合并排序
- 消息：登录后展示真实回复/@；游客展示用途说明与登录引导
- 登录：Android/Windows 可在内置 WebView 完成百度登录，自动读取 HttpOnly Cookie 中的 BDUSS/STOKEN；Windows 依赖 WebView2 Runtime，手动粘贴作为兜底
- 我的：账号资料/统计、本地历史/收藏/关注、外观/缓存/关于/开源许可
- 搜索：相关贴吧 2 列卡片（可查看全部）+ 协议层全站讨论，点击进入吧或帖子
- 吧页：渐变吧头、排序 chips、缩略图信息流
- 帖子页：协议层楼层卡片、富文本/图片网格、楼中楼 BottomSheet、收藏/复制链接、点赞接口

设计说明与许可证边界见 [docs/ui-design.md](docs/ui-design.md)。界面已迁移到官方
`material_ui` 包，并使用当前官方提供的 M3 Expressive 形状、IconButton 和转场能力；
没有引入完整的第三方 M3E 组件包。关注/广场/吧页/帖子页均已使用
`lib/data/protocol_browse_repository.dart` 的协议层数据；搜索同时使用协议吧搜索和 `fetchSearchGlobal`，
登录校验使用 `fetchLogin`，登录后的消息/资料/关注/点赞/签到通过
`lib/core/tieba_api.dart` 调用协议层。

> 说明：TiebaLite 采用 GPL-3.0，而 Feiba 采用 MIT。本版只参考其布局/交互，
> 未复制其代码、图片、字体或 drawable；如要直接使用其素材，需要先调整项目许可证或取得授权。

## 协议层（aiotieba 移植）

协议层位于 `lib/protocol/`，是 [aiotieba](https://github.com/lumina37/aiotieba)（Unlicense）4.8.2 的 Dart 移植：

- 三种传输：APP 表单签名、APP protobuf（`tiebac.baidu.com`）、WEB（`tieba.baidu.com`）
- 账号派生字段：android_id / uuid / cuid / cuid_galaxy2 / c3_aid / tbs
- 已覆盖 aiotieba 4.8.2 的全部 API 模块：吧/帖/楼中楼、搜索、用户/主页/历史、通知、吧务、恢复/申诉、排行、图片、全部读写操作，以及 BLCP/WebSocket 聊天/IM
- `proto/` 为移植的 protobuf schema，生成代码在 `lib/protocol/generated/`

> 浏览链路已使用 `lib/data/protocol_browse_repository.dart` 的协议层 `getThreads/getPosts`；搜索同时返回相关吧与相关讨论，登录校验使用 `fetchLogin`；账号动作通过 `lib/core/tieba_api.dart`。覆盖清单见 [docs/port-checklist.md](docs/port-checklist.md)，设计与验证边界见 [docs/aiotieba-port.md](docs/aiotieba-port.md)。

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

## Windows 安装器

使用标准 NSIS 安装器，默认安装到 `C:\Program Files\Feiba`，需要管理员权限：

```bash
flutter build windows --release
makensis tool/feiba_setup.nsi
```

输出：`build/installer/Feiba-Setup-0.1.0.exe`。安装器创建开始菜单和桌面快捷方式，并注册卸载程序。
安装包没有商业代码签名证书，Windows SmartScreen 会提示“未知发布者”；选择“运行”即可。

## 首页与帖子卡片

- 首页默认显示关注的吧；最近点击过的吧以带头像的 Material 3 ActionChip 横向排列在关注的吧上方。
- 吧内、吧外帖子都使用响应式瀑布流；吧外帖子额外显示可点击的吧 chip。
- 帖子页使用自定义 SliverPersistentHeader：标题和吧 chip 在展开区完整显示，滚动后折叠为 64dp 工具栏。
- 帖子、吧页面和图片查看器使用 Flutter 默认页面转场；Android 启用官方 `PredictiveBackPageTransitionsBuilder` 预测性返回动画。

- 底部/侧边导航切换页面时使用 280ms 淡入 + 轻微横向滑动过渡。
- Android 使用官方预测性返回手势动画；图片查看器使用 PhotoView 的缩放、切图和下拉关闭。

## 吧内榜单

吧页顶部提供“榜单”入口，包含签到榜（今日/昨日/周榜/月榜）、等级榜和最新成员，支持分页与下拉刷新。

## 自适应布局

- < 600dp：底部导航栏
- 600–1199dp：左侧导航栏
- >= 1200dp：左侧扩展导航栏
- 页面内容在宽屏下限制为 1200dp 并居中，网格按可用宽度自动增减列数

## 许可证

MIT
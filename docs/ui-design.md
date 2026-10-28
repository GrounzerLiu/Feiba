# Feiba UI 设计

> 目标：把 Feiba 从“能用”提升为“愿意每天打开”的贴吧客户端界面。
> 参考：TiebaLite 4.x 的信息层级、底部导航、信息流卡片和帖子详情结构。
> 实现：Flutter / Material 3。首页/吧页/帖子页使用 `lib/data/protocol_browse_repository.dart` 的协议层 `getThreads` / `getPosts` / `getComments`；搜索使用 `fetchSearchGlobal`，登录校验使用 `fetchLogin`，账号动作通过 `lib/core/tieba_api.dart`。

## 1. 参考与素材边界

TiebaLite（HuanCheng65/TiebaLite）采用 **GPL-3.0** 许可证；Feiba 当前是 **MIT**。
直接把 TiebaLite 的 Kotlin 代码、矢量图标、字体或图片复制进 Feiba，会使 Feiba 成为 GPL
衍生作品，和当前 MIT 声明冲突，也可能涉及百度贴吧素材的商标/版权问题。

因此本版：

- 参考了 TiebaLite 的**布局、导航结构、卡片密度、信息层级**；
- 没有复制 TiebaLite 的代码、图片、字体或 drawable；
- 图标使用 Flutter Material Icons，头像使用用户网络头像 + 首字母色块；
- 颜色使用贴吧蓝 `#4477E0` 作为品牌色。

如果后续确定将 Feiba 改为 GPL-3.0，或取得 TiebaLite 素材的独立授权，可以再替换为
其动画图标和字体；届时需要同步更新 LICENSE 与 THIRD_PARTY_NOTICES。

## 2. 视觉方向

关键词：**安静、留白、信息流、轻量**。

- 背景使用冷灰 `#F3F6FA`，卡片纯白，不使用高阴影；
- 主色贴吧蓝，辅助色按兴趣分类（游戏蓝、二次元紫、数码绿、体育橙、生活粉）；
- 大圆角：卡片 18、搜索框 16、头像全圆；
- 标题字重 700–800，正文行高 1.55–1.6；
- 所有页面支持浅色/深色（跟随系统）。

### Design tokens

| Token | Light | Dark |
| --- | --- | --- |
| primary | `#4477E0` | `#6E9BFF` |
| background | `#F3F6FA` | `#0D131B` |
| surface | `#FFFFFF` | `#141C26` |
| surfaceContainerHighest | `#F0F3F8` | `#222C39` |
| onSurface | `#1B2433` | `#E7EDF5` |
| outlineVariant | `#E8EDF4` | `#2B3746` |
| card radius | 18 | 18 |
| page padding | 16–20 | 16–20 |

## 3. 全局结构

底部四栏导航（`MainShell`）：

1. **首页**：搜索入口、常逛吧、热门讨论信息流、兴趣分类；
2. **发现**：按兴趣浏览、热门吧列表、搜索入口；
3. **消息**：登录后从协议层拉取回复/@；游客看到登录引导与使用说明；
4. **我的**：账号资料、统计、关注/历史/收藏、外观、缓存、关于与开源许可。

首页/发现/消息/我的使用 `IndexedStack` 保持状态；登录相关页面在切换 tab 时刷新。
桌面端暂沿用同一套底部导航，后续可为宽屏切换 NavigationRail。

## 4. 页面设计

### 首页（HomePage）

- 顶部：品牌标题“贴吧”+ 一句副标题 + 圆形账号入口；
- 搜索条：浅蓝色块，点击进入搜索页；
- 常逛的吧：横向卡片，圆形兴趣图标 + 吧名 + 分类；
- 热门讨论：来自原神吧的真实信息流，使用 `ThreadCard`；
- 探索更多：兴趣 chips；
- 下拉刷新、加载骨架、错误卡片、空态。

### 吧页（ForumPage）

- AppBar + 渐变吧头：吧头像、吧名、简介、成员/帖子数、关注按钮；
- 三个排序 chips：最新回复 / 最新发布 / 精品；
- 帖子信息流：作者头像、标题、摘要、最多 3 张缩略图、浏览/回复/赞；
- 滚动加载更多；下拉刷新；空态/错误态。

### 帖子页（ThreadPage）

- AppBar 显示标题，分享入口；
- 楼层卡片：头像、用户名、时间、楼主/楼层标记；
- 富文本 `ContentView`：文本、表情、链接、图片网格；
- 楼中楼先在楼层内展示协议层返回的预览，点击后在可上拉全屏的 BottomSheet 中分页展开；
- 底部悬浮回复栏 + 真实点赞接口（`setAgree`）；游客点击时弹出登录引导；
- AppBar 支持本地收藏与复制帖子链接；
- 楼中楼展开上限从 10 页放宽到 100 页。

### 搜索页（SearchPage）

- 返回键 + 圆角搜索框 + 搜索按钮；
- 未搜索时展示最近搜索、热门搜索与引导空态；最近搜索保存在本机；
- 结果卡片：吧头像、吧名、关注/帖子数；
- 加载、空结果、错误、重试。

### 登录页（LoginPage）

- 蓝色渐变品牌头 + 登录说明；
- BDUSS 默认隐藏，可切换显示；STOKEN 可选；
- 登录按钮、状态消息、退出登录；BDUSS 由协议层 `fetchLogin` 校验；游客可直接返回继续浏览；
- “如何获取 BDUSS”折叠说明；
- 凭据仅本机保存的提示。

### 消息 / 我的

- 消息：全部/回复/@ 筛选；登录后展示真实回复与 @；游客展示用途说明与登录 CTA；
- 我的：渐变个人信息头；登录后用协议层 `fetchUserInfo` 填充关注/粉丝/发帖；游客展示本地浏览/收藏/关注统计；
- 本地空间：浏览历史、收藏、本地关注三个 tab，均可在未登录状态使用；
- 设置：浅色/深色/跟随系统、清理图片缓存、关于、开源许可。
- 账号相关动作（点赞、关注、签到、消息、资料）通过协议层；未登录时统一弹出登录引导，不把游客挡在浏览之外。

## 5. 组件

| 组件 | 文件 | 用途 |
| --- | --- | --- |
| MainShell | lib/ui/main_shell.dart | 四栏导航与外层 Scaffold |
| ThreadCard | lib/ui/widgets/thread_card.dart | 吧/首页信息流卡片 |
| ContentView | lib/ui/widgets/content_view.dart | 文本、表情、链接、图片网格 |
| NameAvatar | lib/ui/widgets/name_avatar.dart | 网络头像 / 首字母色块 |
| SectionHeader | lib/ui/widgets/section_header.dart | 分组标题与动作 |
| EmptyState | lib/ui/widgets/empty_state.dart | 统一空态 |
| ProtocolBrowseRepository | lib/data/protocol_browse_repository.dart | 协议层信息流/帖子/楼中楼适配 |
| LibraryPage | lib/ui/library_page.dart | 本地历史/收藏/关注 |
| LocalLibrary | lib/core/local_library.dart | 游客本地历史、收藏、关注与搜索 |
| ThemeController | lib/core/theme_controller.dart | 外观模式持久化 |
| TiebaApi | lib/core/tieba_api.dart | 账号动作与通知的协议桥 |
| AuthGate | lib/ui/auth_gate.dart | 游客登录引导 BottomSheet |
| format.dart | lib/ui/format.dart | 数字缩写、相对时间 |

## 6. 状态与错误

- 加载：居中进度或卡片骨架；
- 空：图标 + 标题 + 说明 + 可选动作；
- 失败：说明 + 重试按钮，不吞异常；
- 下拉刷新：首页、吧页、帖子页；
- 无限滚动：吧页、帖子页。

## 7. 数据边界

首页信息流、吧页帖子列表和帖子页楼层/楼中楼已切换到
`lib/data/protocol_browse_repository.dart`，底层是协议层的
`fetchThreads` / `fetchPosts` / `fetchComments`。

搜索同时使用协议吧搜索和 `fetchSearchGlobal`，登录校验使用 `fetchLogin`；账号动作通过
`lib/core/tieba_api.dart` 调协议层。旧 JSON 端点只保留在工具和兼容代码中。

已接入协议层：

- 登录后消息：`fetchReplies` / `fetchAts`；
- 账号资料与关注/粉丝/发帖统计：`fetchLogin` + `fetchUserInfo`；
- 吧关注/取消关注：`followForum` / `unfollowForum`；
- 吧签到：`signForum`；
- 帖子点赞/取消：`setAgree`；
- 游客本地历史、收藏、关注、最近搜索和外观设置：SharedPreferences，受限环境自动退回内存。

暂未接入：

- 发帖/回复编辑器；
- 收藏与账号收藏的同步；
- 视频播放；
- 吧务/聊天等深水区 UI。

这些位置明确标注，避免游客误以为操作已成功。

## 8. 测试

- `test/widget_test.dart`：壳层渲染、底部导航、发现页切换；
- `test/ui_components_test.dart`：ThreadCard 深色主题、NameAvatar 圆形裁切；
- `test/local_library_test.dart`：游客历史/收藏/关注、最近搜索、主题持久化；
- `test/guest_ui_test.dart`：游客个人页、本地空间 tabs；
- `test/tieba_api_test.dart`：未登录/BDUSS 格式错误时协议桥的拒绝与错误文案；
- `test/login_page_test.dart`：登录页走协议校验并显示错误；
- 协议层信息流通过 `tool/protocol_smoke.dart` 与真机页面联调；
- 首页通过 `HomePage(loadFeed: false)` 支持无网络组件测试；
- 组件测试不依赖真实贴吧接口。
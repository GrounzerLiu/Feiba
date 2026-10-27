# Feiba UI 设计

> 目标：把 Feiba 从“能用”提升为“愿意每天打开”的贴吧客户端界面。
> 参考：TiebaLite 4.x 的信息层级、底部导航、信息流卡片和帖子详情结构。
> 实现：Flutter / Material 3，现有 `lib/data` 旧 JSON 数据链路。

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
3. **消息**：回复/@/系统通知的空态与登录引导；
4. **我的**：账号、统计占位、关注/历史/收藏、设置与关于。

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
- 楼中楼先在楼层内展示预览，点击后在底部 BottomSheet 中分页展开；
- 底部悬浮回复栏 + 点赞入口（当前为交互占位）；
- 楼中楼展开上限从 10 页放宽到 100 页。

### 搜索页（SearchPage）

- 返回键 + 圆角搜索框 + 搜索按钮；
- 未搜索时展示热门搜索与引导空态；
- 结果卡片：吧头像、吧名、关注/帖子数；
- 加载、空结果、错误、重试。

### 登录页（LoginPage）

- 蓝色渐变品牌头 + 登录说明；
- BDUSS 默认隐藏，可切换显示；STOKEN 可选；
- 登录按钮、状态消息、退出登录；
- “如何获取 BDUSS”折叠说明；
- 凭据仅本机保存的提示。

### 消息 / 我的

- 消息：全部/回复/@ 筛选；未登录引导登录；登录后空态提示；
- 我的：渐变个人信息头、统计占位、菜单卡片、关于对话框；
- 未接入的数据统一用“—”或“正在接入中”提示，不伪造数据。

## 5. 组件

| 组件 | 文件 | 用途 |
| --- | --- | --- |
| MainShell | lib/ui/main_shell.dart | 四栏导航与外层 Scaffold |
| ThreadCard | lib/ui/widgets/thread_card.dart | 吧/首页信息流卡片 |
| ContentView | lib/ui/widgets/content_view.dart | 文本、表情、链接、图片网格 |
| NameAvatar | lib/ui/widgets/name_avatar.dart | 网络头像 / 首字母色块 |
| SectionHeader | lib/ui/widgets/section_header.dart | 分组标题与动作 |
| EmptyState | lib/ui/widgets/empty_state.dart | 统一空态 |
| format.dart | lib/ui/format.dart | 数字缩写、相对时间 |

## 6. 状态与错误

- 加载：居中进度或卡片骨架；
- 空：图标 + 标题 + 说明 + 可选动作；
- 失败：说明 + 重试按钮，不吞异常；
- 下拉刷新：首页、吧页、帖子页；
- 无限滚动：吧页、帖子页。

## 7. 数据边界

当前 UI 仍使用 `lib/data/tieba_repository.dart` 的旧 JSON 链路；
协议层 `lib/protocol` 已全量移植，但尚未替换 UI 数据源。

本版新增/修改的交互：

- 吧页排序：`latest reply` / `latest post` / `good`（`sort_type` / `is_good`）；
- 帖子页楼中楼展开：最多 100 页；
- 登录状态刷新：切换 tab 时重建登录相关 tab。

暂未接入：

- 回复/点赞/关注/收藏的真实写操作；
- 消息列表数据；
- 用户主页真实统计；
- 设置持久化；
- 视频播放。

这些位置都明确标注“正在接入中”，避免误导。

## 8. 测试

- `test/widget_test.dart`：壳层渲染、底部导航、发现页切换；
- `test/ui_components_test.dart`：ThreadCard 深色主题渲染；
- 首页通过 `HomePage(loadFeed: false)` 支持无网络组件测试；
- 组件测试不依赖真实贴吧接口。
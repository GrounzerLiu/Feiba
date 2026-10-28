# Windows 调试手册

Feiba 的 Windows 版本没有 DOM 或 Web 调试器，验证界面时使用 DSH 的
**Computer Use（wincu）** 插件。它可以直接截图、点击、滚轮和拖动，
不需要另外安装自动化工具。

## 1. 找到窗口

先启动 Windows 版本，然后：

```text
windows_computer_use_list_windows
```

找到：

- name: `feiba`
- className: `FLUTTER_RUNNER_WIN32_WINDOW`
- 其中的 `nativeWindowHandle`

激活窗口：

```json
{"nativeWindowHandle": 1378040}
```

调用 `windows_computer_use_activate_window`。

## 2. 截图

调用无参数的：

```text
windows_computer_use_screenshot
```

返回示例：

```json
{
  "bounds": {"x": 24, "y": 15, "width": 1902, "height": 1071},
  "imageScale": 0.8412,
  "origin": {"x": 24, "y": 15}
}
```

截图会包含标题栏和 Feiba 内容。Flutter 绘制区通常在 UIA 中对应
`FLUTTERVIEW`，例如 `(26, 60, 1898x1024)`。

截图坐标换算成屏幕点击坐标：

```text
screenX = origin.x + imageX / imageScale
screenY = origin.y + imageY / imageScale
```

## 3. 点击

`windows_computer_use_click` 接受物理屏幕坐标：

```json
{"x": 736, "y": 1040}
```

点击后重新截图验证，不要只根据工具返回的 `ok` 判断页面已经变化。

## 4. 滚动

`windows_computer_use_scroll`：

```json
{"x": 800, "y": 700, "deltaY": 600}
```

在 Feiba 的 ListView / TabBarView 上，鼠标滚轮可以正常滚动。
`deltaY` 为正时向下滚动。

## 5. 拖动

`windows_computer_use_drag` 接受屏幕坐标路径：

```json
{
  "path": [
    {"x": 1200, "y": 600},
    {"x": 500, "y": 600}
  ]
}
```

拖动适合验证 BottomSheet、轮播等真正响应拖动的手势。

桌面 Flutter 的普通列表不使用鼠标拖动滚动；滚轮才是正确操作。
TabBarView 也不会因为鼠标横向拖动而切换，桌面验证时直接点击 Tab。

## 6. UIA 与 OCR

`windows_computer_use_snapshot` 能拿到 Windows 顶层窗口和标题栏，
但 Flutter 的语义树通常只暴露为 `FLUTTERVIEW` 下的 Custom 节点，
不能依赖控件名称点击。

可以组合：

- `windows_computer_use_ocr`：读取当前画面文字并拿屏幕坐标；
- `windows_computer_use_find`：查找 UIA/OCR 控件；
- 截图 + 坐标点击：最稳定的 Flutter Windows 验证方式。

## 7. 推荐验证顺序

1. 激活窗口并截一张全窗口图
2. 用截图确认当前页面和缩放比例
3. 点击目标控件
4. 再截一张图，确认状态变化
5. 用滚轮验证长列表
6. 用拖动验证需要手势的组件
7. 最后执行 `flutter analyze` 和 `flutter test`

截图与点击都不要依赖上一次的坐标；窗口移动、DPI 或页面切换后要重新截图。

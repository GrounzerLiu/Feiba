import 'dart:async';
import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter_windows/webview_flutter_windows.dart';

/// In-app login for Windows, backed by the maintained WebView2 package.
///
/// WebView2 exposes HttpOnly cookies through its cookie manager, so BDUSS can
/// be read without JavaScript.
class WindowsWebLoginView extends StatefulWidget {
  const WindowsWebLoginView({
    super.key,
    required this.onCookies,
    required this.onClose,
  });

  final Future<void> Function(String bduss, String stoken) onCookies;
  final VoidCallback onClose;

  @override
  State<WindowsWebLoginView> createState() => _WindowsWebLoginViewState();
}

class _WindowsWebLoginViewState extends State<WindowsWebLoginView> {
  static const String _loginUrl =
      'https://wappass.baidu.com/passport?login&u=https%3A%2F%2Ftieba.baidu.com%2Findex%2Ftbwise%2Fmine';

  final WebviewController _controller = WebviewController();
  StreamSubscription<String>? _urlSubscription;
  bool _loading = true;
  bool _checking = false;
  bool _finished = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_init());
  }

  String _joinPath(String base, String name) {
    return '$base${Platform.pathSeparator}$name';
  }

  Future<String> _webViewDataPath() async {
    final candidates = <String>[];
    try {
      final support = await getApplicationSupportDirectory();
      candidates.add(_joinPath(support.path, 'webview2'));
    } catch (_) {}
    candidates.add(
      _joinPath(File(Platform.resolvedExecutable).parent.path, 'webview2_data'),
    );
    candidates.add(_joinPath(Directory.systemTemp.path, 'feiba_webview2'));
    for (final candidate in candidates) {
      try {
        await Directory(candidate).create(recursive: true);
        return candidate;
      } catch (_) {}
    }
    throw StateError('没有可写的 WebView2 数据目录');
  }

  Future<void> _init() async {
    try {
      final dataPath = await _webViewDataPath();
      await WebviewController.initializeEnvironment(userDataPath: dataPath);
      await _controller.initialize();
      _urlSubscription = _controller.url.listen((url) {
        final uri = Uri.tryParse(url);
        if (uri == null) return;
        final host = uri.host.toLowerCase();
        if (host == 'tieba.baidu.com' || host == 'tiebac.baidu.com') {
          unawaited(_checkCookies());
        }
      });
      await _controller.loadUrl(_loginUrl);
      if (!mounted) return;
      setState(() => _loading = false);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'WebView2 初始化失败：$error';
      });
    }
  }

  Future<void> _checkCookies() async {
    if (_finished || _checking) return;
    _checking = true;
    try {
      final cookies = await _controller.getCookies('https://tieba.baidu.com/');
      final values = <String, String>{};
      for (final cookie in cookies) {
        values[cookie.name.toUpperCase()] = cookie.value;
      }
      final bduss = values['BDUSS']?.trim() ?? '';
      final stoken = values['STOKEN']?.trim() ?? '';
      if (bduss.isEmpty) return;
      _finished = true;
      await widget.onCookies(bduss, stoken);
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = '读取登录信息失败：$error');
    } finally {
      _checking = false;
    }
  }

  @override
  void dispose() {
    _urlSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Text(
            _error!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    if (_loading || !_controller.value.isInitialized) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 14),
            Text('正在打开贴吧网页登录…'),
          ],
        ),
      );
    }
    return Webview(_controller);
  }
}
import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import '../core/session.dart';
import '../core/tieba_api.dart';
import '../protocol/core/exceptions.dart';
import 'web_login_windows.dart';

const MethodChannel _loginChannel = MethodChannel('feiba/login');

/// Clears the cookies used by the native Android login WebView.
Future<void> clearWebLoginCookies() async {
  if (!Platform.isAndroid) return;
  try {
    await _loginChannel.invokeMethod<void>('clearCookies');
  } catch (_) {
    // Cookie cleanup is best effort.
  }
}

/// Opens the native Android WebView used for Baidu passport login.
///
/// BDUSS is HttpOnly, so it cannot be read from JavaScript. The native
/// activity reads the Android cookie store after the passport redirect and
/// returns the cookie header; Dart validates it with the normal login API.
class WebLoginPage extends StatefulWidget {
  const WebLoginPage({super.key});

  @override
  State<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
  bool _busy = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) _openLogin();
  }

  Future<void> _openLogin() async {
    if (!Platform.isAndroid) {
      if (mounted) Navigator.of(context).pop(false);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final rawCookies = await _loginChannel.invokeMethod<String>('openLogin');
      if (rawCookies == null || rawCookies.trim().isEmpty) {
        if (mounted) Navigator.of(context).pop(false);
        return;
      }
      final values = <String, String>{};
      for (final part in rawCookies.split(';')) {
        final index = part.indexOf('=');
        if (index <= 0) continue;
        final name = part.substring(0, index).trim().toUpperCase();
        final value = part.substring(index + 1).trim();
        if (name.isNotEmpty) values[name] = value;
      }
      final bduss = values['BDUSS']?.trim() ?? '';
      final stoken = values['STOKEN']?.trim() ?? '';
      if (bduss.isEmpty) {
        throw const TiebaValueException('网页登录没有返回 BDUSS，请重新登录');
      }
      TiebaApi.instance.reset();
      final info = await TiebaApi.instance.validateCredentials(
        bduss,
        stoken: stoken,
      );
      await Session.instance.save(
        bduss: bduss,
        stoken: stoken,
        userName: info.userName,
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on TiebaException catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = error.message;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = '网页登录失败：$error';
      });
    }
  }

  Future<void> _onWindowsCookies(String bduss, String stoken) async {
    try {
      TiebaApi.instance.reset();
      final info = await TiebaApi.instance.validateCredentials(
        bduss,
        stoken: stoken,
      );
      await Session.instance.save(
        bduss: bduss,
        stoken: stoken,
        userName: info.userName,
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on TiebaException catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = error.message;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = '网页登录失败：$error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (Platform.isWindows) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('网页登录'),
          leading: IconButton(
            tooltip: '关闭',
            onPressed: () async {
              await clearWebLoginCookies();
              if (!context.mounted) return;
              Navigator.of(context).pop(false);
            },
            icon: const Icon(Icons.close_rounded),
          ),
        ),
        body: _error != null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              )
            : WindowsWebLoginView(
                onCookies: _onWindowsCookies,
                onClose: () => Navigator.of(context).pop(false),
              ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('网页登录'),
        leading: IconButton(
          tooltip: '关闭',
          onPressed: () => Navigator.of(context).pop(false),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (_busy) ...<Widget>[
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text('正在打开贴吧网页登录…', style: theme.textTheme.bodyMedium),
                const SizedBox(height: 5),
                Text(
                  '登录成功后会自动返回并验证账号',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ] else ...<Widget>[
                Icon(
                  Icons.error_outline_rounded,
                  size: 40,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 12),
                Text(
                  _error ?? '网页登录未完成',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                FilledButton(onPressed: _openLogin, child: const Text('重新登录')),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('取消'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
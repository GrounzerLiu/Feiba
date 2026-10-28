import 'dart:io';

import 'package:flutter/material.dart';

import '../core/session.dart';
import '../core/tieba_api.dart';
import '../protocol/core/exceptions.dart';
import 'web_login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _bduss = TextEditingController(
    text: Session.instance.bduss ?? '',
  );
  late final TextEditingController _stoken = TextEditingController(
    text: Session.instance.stoken ?? '',
  );

  bool _busy = false;
  bool _obscure = true;
  String? _message;
  bool _success = false;

  @override
  void dispose() {
    _bduss.dispose();
    _stoken.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final value = _bduss.text.trim();
    if (value.isEmpty) {
      setState(() {
        _success = false;
        _message = '请先填写 BDUSS';
      });
      return;
    }
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      TiebaApi.instance.reset();
      final account = await TiebaApi.instance.validateCredentials(
        value,
        stoken: _stoken.text.trim(),
      );
      await Session.instance.save(
        bduss: value,
        stoken: _stoken.text.trim(),
        userName: account.userName,
      );
      if (!mounted) return;
      setState(() {
        _success = true;
        _message = '登录成功：${account.userName}';
      });
    } on TiebaException catch (error) {
      if (!mounted) return;
      setState(() {
        _success = false;
        _message = '验证失败：${error.message}';
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _success = false;
        _message = '网络错误：$error';
      });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _webLogin() async {
    final result = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute<bool>(builder: (_) => const WebLoginPage()));
    if (result != true || !mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> _logout() async {
    try {
      await clearWebLoginCookies();
    } catch (_) {
      // Cookie cleanup is best effort.
    }
    TiebaApi.instance.reset();
    await Session.instance.clear();
    if (!mounted) return;
    setState(() {
      _bduss.clear();
      _stoken.clear();
      _success = false;
      _message = '已退出登录';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loggedIn = Session.instance.isLoggedIn;
    return Scaffold(
      appBar: AppBar(title: const Text('账号')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withValues(alpha: 0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.forum_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        loggedIn ? '已登录' : '登录 Feiba',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loggedIn
                            ? '当前账号 ${Session.instance.userName ?? ''}'
                            : '浏览和搜索无需登录；登录后使用回复、消息和账号功能',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.78),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (Platform.isAndroid) ...<Widget>[
            FilledButton.icon(
              onPressed: _busy ? null : _webLogin,
              icon: const Icon(Icons.open_in_browser_rounded),
              label: const Text('通过网页登录'),
            ),
            const SizedBox(height: 6),
            Text(
              '在贴吧网页完成登录，自动获取 BDUSS/STOKEN',
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ] else
            Text(
              '桌面端请手动粘贴 BDUSS；Android 支持内置网页登录',
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          if (loggedIn) ...<Widget>[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.verified_user_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      Session.instance.userName ?? '已登录',
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  TextButton(onPressed: _logout, child: const Text('退出')),
                ],
              ),
            ),
          ],
          const SizedBox(height: 18),
          Text('或手动粘贴 Cookie', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _bduss,
            obscureText: _obscure,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: 'BDUSS',
              hintText: '粘贴浏览器 Cookie 中的 BDUSS',
              suffixIcon: IconButton(
                tooltip: _obscure ? '显示' : '隐藏',
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _stoken,
            maxLines: 1,
            decoration: const InputDecoration(
              labelText: 'STOKEN（可选）',
              hintText: '部分吧务接口需要',
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _busy ? null : _save,
            icon: _busy
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.login_rounded),
            label: Text(_busy ? '验证中…' : '登录'),
          ),
          if (_message != null) ...<Widget>[
            const SizedBox(height: 12),
            Text(
              _message!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: _success
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
              ),
            ),
          ],
          if (Session.instance.persistenceError != null) ...<Widget>[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      Session.instance.persistenceError!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('先逛逛，暂不登录'),
          ),
          const SizedBox(height: 22),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: ExpansionTile(
              shape: const Border(),
              leading: Icon(
                Icons.help_outline_rounded,
                color: theme.colorScheme.primary,
              ),
              title: const Text('如何获取 BDUSS？'),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              children: <Widget>[
                Text(
                  '1. 在浏览器登录 tieba.baidu.com\n'
                  '2. 打开开发者工具 → Application → Cookies\n'
                  '3. 复制 BDUSS 的值粘贴到上方\n\n'
                  '凭据只保存在本机，不会上传到 Feiba 服务器。',
                  style: theme.textTheme.bodySmall?.copyWith(height: 1.7),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Feiba 是第三方客户端，与百度贴吧官方无关。',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

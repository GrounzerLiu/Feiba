import 'package:flutter/material.dart';

import '../core/session.dart';
import '../core/tieba_client.dart';
import '../data/tieba_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TiebaRepository _repo = TiebaRepository();
  late final TextEditingController _bduss =
      TextEditingController(text: Session.instance.bduss ?? '');
  late final TextEditingController _stoken =
      TextEditingController(text: Session.instance.stoken ?? '');

  bool _busy = false;
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
      final account = await _repo.checkAccount(value);
      if (!mounted) return;
      if (account == null) {
        setState(() {
          _success = false;
          _message = 'BDUSS 无效或已过期';
        });
        return;
      }
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
    } on TiebaApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _success = false;
        _message = '验证失败：${e.message}';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _success = false;
        _message = '网络错误：$e';
      });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _logout() async {
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
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          if (loggedIn)
            Card(
              child: ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text(Session.instance.userName ?? '已登录'),
                subtitle: Text('BDUSS ${_mask(Session.instance.bduss)}'),
                trailing: TextButton(
                  onPressed: _logout,
                  child: const Text('退出'),
                ),
              ),
            ),
          const SizedBox(height: 12),
          TextField(
            controller: _bduss,
            maxLines: 3,
            minLines: 1,
            decoration: const InputDecoration(
              labelText: 'BDUSS',
              helperText: '从浏览器 Cookie 中复制 BDUSS 的值',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _stoken,
            maxLines: 2,
            minLines: 1,
            decoration: const InputDecoration(
              labelText: 'STOKEN（可选）',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _busy ? null : _save,
            icon: _busy
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.login),
            label: Text(_busy ? '验证中…' : '登录'),
          ),
          if (_message != null) ...<Widget>[
            const SizedBox(height: 12),
            Text(
              _message!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: _success ? theme.colorScheme.primary : theme.colorScheme.error,
              ),
            ),
          ],
          const SizedBox(height: 24),
          Text(
            '说明：登录凭据仅保存在本机，用于携带 BDUSS 访问贴吧接口。',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  static String _mask(String? value) {
    if (value == null || value.length < 12) return '***';
    return '${value.substring(0, 6)}…${value.substring(value.length - 4)}';
  }
}

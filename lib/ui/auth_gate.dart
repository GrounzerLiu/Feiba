import 'package:material_ui/material_ui.dart';

import '../core/session.dart';
import 'login_page.dart';

/// Returns true when the user is logged in.
///
/// Guests can keep browsing; only account-bound actions show this sheet.
/// After a successful login the action can continue immediately.
Future<bool> ensureLoggedIn(
  BuildContext context, {
  required String action,
  String? description,
}) async {
  if (Session.instance.isLoggedIn) return true;

  final goToLogin = await showModalBottomSheet<bool>(
    context: context,
    showDragHandle: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (sheetContext) {
      final theme = Theme.of(sheetContext);
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: 58,
              height: 58,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_open_rounded,
                color: theme.colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '登录后$action',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              description ?? '登录贴吧账号即可使用该功能，浏览帖子和搜索不需要登录。',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 22),
            FilledButton(
              onPressed: () => Navigator.of(sheetContext).pop(true),
              child: const Text('去登录'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(sheetContext).pop(false),
              child: const Text('先逛逛'),
            ),
          ],
        ),
      );
    },
  );

  if (goToLogin != true || !context.mounted) return false;
  await Navigator.of(context)
      .push(MaterialPageRoute<void>(builder: (_) => const LoginPage()));
  return Session.instance.isLoggedIn;
}

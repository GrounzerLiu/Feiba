import 'package:material_ui/material_ui.dart';

import '../../core/local_library.dart';
import '../../data/models/forum_summary.dart';
import '../../data/protocol_browse_repository.dart';
import 'forum_avatar.dart';

/// Followed-forum card used on the home "吧" tab.
///
/// It keeps the level and sign-in state visible, so it intentionally uses a
/// card rather than a compact chip.
class ForumFollowCard extends StatelessWidget {
  const ForumFollowCard({
    super.key,
    required this.forum,
    required this.repo,
    required this.onTap,
  });

  final ForumSummary forum;
  final ProtocolBrowseRepository repo;
  final VoidCallback onTap;

  /// Tieba level ranges use distinct colors from gray through red.
  static Color levelColor(int level) {
    if (level >= 16) return const Color(0xFFD94F4F);
    if (level >= 13) return const Color(0xFFD98035);
    if (level >= 10) return const Color(0xFF8A6BE8);
    if (level >= 7) return const Color(0xFF4C8DFF);
    if (level >= 4) return const Color(0xFF3FAE8F);
    return const Color(0xFF8A8F98);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final level = forum.level;
    final color = levelColor(level);
    final local = forum.isLocal;
    final signed = forum.isSigned;
    final signLabel = local ? '本地关注' : (signed ? '已签到' : '未签到');
    final signColor = local
        ? theme.colorScheme.onSurfaceVariant
        : signed
        ? const Color(0xFF3FAE8F)
        : theme.colorScheme.onSurfaceVariant;
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          LocalLibrary.instance.recordForumVisit(forum.name);
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
          child: Row(
            children: <Widget>[
              ForumAvatar(name: forum.name, repo: repo, size: 40),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      forum.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            level > 0 ? 'Lv.$level' : 'Lv.--',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: color,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Icon(
                          local
                              ? Icons.home_outlined
                              : signed
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked,
                          size: 13,
                          color: signColor,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          signLabel,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: signColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 2),
              const Icon(Icons.chevron_right_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
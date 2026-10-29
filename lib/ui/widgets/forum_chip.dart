import 'package:material_ui/material_ui.dart';

import '../../core/local_library.dart';
import '../../data/protocol_browse_repository.dart';
import '../forum_page.dart';
import 'forum_avatar.dart';

/// Material 3 action chip for a forum, with a lazily loaded avatar.
class ForumChip extends StatelessWidget {
  const ForumChip({
    super.key,
    required this.name,
    required this.repo,
    this.onPressed,
    this.dense = false,
    this.recordVisit = true,
  });

  final String name;
  final ProtocolBrowseRepository repo;
  final VoidCallback? onPressed;
  final bool dense;
  final bool recordVisit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = name.trim().isEmpty ? '贴吧' : name.trim();
    return ActionChip(
      avatar: ForumAvatar(name: label, repo: repo, size: dense ? 20 : 24),
      label: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: dense ? 220 : 260),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onPressed: onPressed == null
          ? null
          : () {
              if (recordVisit) {
                LocalLibrary.instance.recordForumVisit(label);
              }
              onPressed!();
            },
      visualDensity: dense ? VisualDensity.compact : VisualDensity.standard,
      materialTapTargetSize: dense
          ? MaterialTapTargetSize.shrinkWrap
          : MaterialTapTargetSize.padded,
      backgroundColor: theme.colorScheme.surfaceContainerLow,
      side: BorderSide(color: theme.colorScheme.outlineVariant),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    );
  }
}

/// Opens the forum page from a forum chip with the default route animation.
class ForumChipOpenContainer extends StatelessWidget {
  const ForumChipOpenContainer({
    super.key,
    required this.name,
    required this.repo,
    this.dense = false,
  });

  final String name;
  final ProtocolBrowseRepository repo;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return ForumChip(
      name: name,
      repo: repo,
      dense: dense,
      recordVisit: false,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ForumPage(forumName: name),
          ),
        );
        LocalLibrary.instance.recordForumVisit(name);
      },
    );
  }
}

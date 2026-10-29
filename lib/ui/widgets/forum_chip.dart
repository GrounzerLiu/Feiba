import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/local_library.dart';
import '../../data/protocol_browse_repository.dart';
import '../forum_page.dart';
import 'forum_avatar.dart';

/// Material 3 action chip for a forum, with a lazily loaded avatar.
///
/// Pressing the chip records the visit time so the recent-forum row can be
/// ordered by the latest actual click.
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
      avatar: ForumAvatar(
        name: label,
        repo: repo,
        size: dense ? 20 : 24,
      ),
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
/// Expands a small forum chip into the forum page with a container transform.
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
    final theme = Theme.of(context);
    return OpenContainer(
      key: ValueKey<String>('forum-open-$name'),
      transitionDuration: const Duration(milliseconds: 300),
      transitionType: ContainerTransitionType.fadeThrough,
      closedColor: theme.colorScheme.surfaceContainerLow,
      openColor: theme.scaffoldBackgroundColor,
      middleColor: theme.scaffoldBackgroundColor,
      closedElevation: 0,
      openElevation: 0,
      closedShape: const StadiumBorder(),
      openShape: const RoundedRectangleBorder(),
      closedBuilder: (context, open) => Material(
        type: MaterialType.transparency,
        child: ForumChip(
          name: name,
          repo: repo,
          dense: dense,
          recordVisit: false,
          onPressed: open,
        ),
      ),
      openBuilder: (context, _) => ForumPage(forumName: name),
      onClosed: (_) {
        Future<void>.delayed(
          const Duration(milliseconds: 340),
          () => LocalLibrary.instance.recordForumVisit(name),
        );
      },
    );
  }
}
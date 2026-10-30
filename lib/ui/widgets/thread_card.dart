import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/image_cache.dart';

import '../../data/models/content_node.dart';
import '../../data/models/forum_page.dart';
import '../../data/protocol_browse_repository.dart';
import '../format.dart';
import 'forum_chip.dart';
import 'name_avatar.dart';

class ThreadCard extends StatelessWidget {
  const ThreadCard({
    super.key,
    required this.thread,
    this.authorName,
    this.authorAvatar,
    this.forumName,
    this.onTap,
    this.forumRepo,
    this.showForumChip = false,
  });

  final ThreadSummary thread;
  final String? authorName;
  final String? authorAvatar;
  final String? forumName;
  final VoidCallback? onTap;
  final ProtocolBrowseRepository? forumRepo;
  final bool showForumChip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final images = thread.content
        .where((ContentNode n) => n.isImage && n.imageUrl != null)
        .toList(growable: false);
    final preview = thread.preview.trim();
    final name = authorName?.isNotEmpty == true
        ? authorName!
        : (thread.authorId == 0 ? '匿名用户' : '用户 ${thread.authorId}');
    final time = relativeTime(
      thread.lastTime > 0 ? thread.lastTime : thread.createTime,
    );

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 13, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  NameAvatar(name: name, imageUrl: authorAvatar, size: 28),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (time.isNotEmpty)
                    Text(
                      time,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              if (thread.isTop || thread.isGood) ...<Widget>[
                Wrap(
                  spacing: 6,
                  children: <Widget>[
                    if (thread.isTop)
                      const _Badge(label: '置顶', kind: _BadgeKind.top),
                    if (thread.isGood)
                      const _Badge(label: '精品', kind: _BadgeKind.good),
                  ],
                ),
                const SizedBox(height: 7),
              ],
              Text(
                thread.title.isEmpty ? '无标题' : thread.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
              if (preview.isNotEmpty) ...<Widget>[
                const SizedBox(height: 6),
                Text(
                  preview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.55,
                  ),
                ),
              ],
              if (images.isNotEmpty) ...<Widget>[
                const SizedBox(height: 10),
                _ImageStrip(nodes: images),
              ],
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: showForumChip &&
                              forumRepo != null &&
                              forumName != null &&
                              forumName!.isNotEmpty
                          ? ForumChipOpenContainer(
                              name: forumName!,
                              repo: forumRepo!,
                              dense: true,
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.forum_outlined,
                                  size: 13,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    forumName == null || forumName!.isEmpty
                                        ? '贴吧'
                                        : forumName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _Metric(
                    icon: Icons.visibility_outlined,
                    value: thread.viewNum,
                  ),
                  const SizedBox(width: 10),
                  _Metric(
                    icon: Icons.mode_comment_outlined,
                    value: thread.replyNum,
                  ),
                  const SizedBox(width: 10),
                  _Metric(
                    icon: Icons.favorite_border_rounded,
                    value: thread.agreeNum,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _BadgeKind { top, good }

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.kind});

  final String label;
  final _BadgeKind kind;

  @override
  Widget build(BuildContext context) {
    final color = kind == _BadgeKind.top
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.value});

  final IconData icon;
  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 13, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 3),
        Text(
          compactCount(value),
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _ImageStrip extends StatelessWidget {
  const _ImageStrip({required this.nodes});

  final List<ContentNode> nodes;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (nodes.length == 1) {
          final node = nodes.first;
          final ratio =
              (node.width != null &&
                  node.height != null &&
                  node.width! > 0 &&
                  node.height! > 0)
              ? node.width! / node.height!
              : 4 / 3;
          final imageWidth = constraints.maxWidth.clamp(0.0, 320.0);
          final imageHeight = (imageWidth / ratio).clamp(120.0, 260.0);
          return Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: imageWidth,
              height: imageHeight,
              child: _image(context, node, borderRadius: 12),
            ),
          );
        }

        const double gap = 6;
        const double height = 112;
        final items = nodes.take(3).toList(growable: false);
        return SizedBox(
          height: height,
          child: Row(
            children: <Widget>[
              for (var i = 0; i < items.length; i++) ...<Widget>[
                if (i > 0) const SizedBox(width: gap),
                Expanded(
                  child: _image(
                    context,
                    items[i],
                    borderRadius: 10,
                    overlay: i == items.length - 1 && nodes.length > items.length
                        ? '+${nodes.length - items.length}'
                        : null,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _image(
    BuildContext context,
    ContentNode node, {
    required double borderRadius,
    String? overlay,
  }) {
    final url = node.imageUrl!;
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: url,
            cacheManager: Platform.isWindows
                ? null
                : FeibaImageCache.managerFor(url),
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 120),
            placeholder: (_, _) => Container(
              color: theme.colorScheme.surfaceContainerHighest,
            ),
            errorWidget: (_, _, _) => Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.broken_image_outlined,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          if (overlay != null)
            Container(
              color: Colors.black.withValues(alpha: 0.45),
              alignment: Alignment.center,
              child: Text(
                overlay,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

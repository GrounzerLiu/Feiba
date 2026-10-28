import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/image_cache.dart';

import '../../data/models/content_node.dart';
import '../hero_tags.dart';
import '../photo_view_page.dart';

/// Renders Tieba rich content: text runs, links, emoticons and image grids.
class ContentView extends StatelessWidget {
  const ContentView({
    super.key,
    required this.nodes,
    this.style,
    this.maxImages = 9,
  });

  final List<ContentNode> nodes;
  final TextStyle? style;
  final int maxImages;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle =
        style ??
        theme.textTheme.bodyMedium?.copyWith(height: 1.6) ??
        const TextStyle();

    final imageUrls = nodes
        .where((node) => node.isImage && node.imageUrl != null)
        .map((node) => node.imageUrl!)
        .take(maxImages)
        .toList(growable: false);

    final blocks = <Widget>[];
    var inline = <InlineSpan>[];
    var pendingImages = <ContentNode>[];
    var imageIndex = 0;

    void flushInline() {
      if (inline.isEmpty) return;
      blocks.add(Text.rich(TextSpan(style: baseStyle, children: inline)));
      inline = <InlineSpan>[];
    }

    void flushImages() {
      if (pendingImages.isEmpty) return;
      final start = imageIndex;
      imageIndex += pendingImages.length;
      flushInline();
      blocks.add(
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 4),
          child: _ImageGrid(
            nodes: pendingImages,
            allUrls: imageUrls,
            startIndex: start,
          ),
        ),
      );
      pendingImages = <ContentNode>[];
    }

    for (final node in nodes) {
      if (node.isImage) {
        if (imageIndex + pendingImages.length >= imageUrls.length) continue;
        pendingImages.add(node);
        continue;
      }
      if (pendingImages.isNotEmpty) flushImages();

      if (node.isEmoticon) {
        final url = node.emoticonUrl;
        if (url != null) {
          inline.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: CachedNetworkImage(
                  imageUrl: url,
                  cacheManager: FeibaImageCache.managerFor(url),
                  width: 22,
                  height: 22,
                  fadeInDuration: const Duration(milliseconds: 80),
                  errorWidget: (_, _, _) => Text(node.text, style: baseStyle),
                ),
              ),
            ),
          );
        }
        continue;
      }

      if (node.isLink) {
        inline.add(
          TextSpan(
            text: node.text,
            style: baseStyle.copyWith(
              color: theme.colorScheme.primary,
              decoration: TextDecoration.underline,
              decorationColor: theme.colorScheme.primary.withValues(
                alpha: 0.35,
              ),
            ),
          ),
        );
        continue;
      }

      if (node.text.isNotEmpty) {
        inline.add(TextSpan(text: node.text, style: baseStyle));
      }
    }

    if (pendingImages.isNotEmpty) flushImages();
    flushInline();

    if (blocks.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: blocks,
    );
  }
}

class _ImageGrid extends StatelessWidget {
  const _ImageGrid({
    required this.nodes,
    required this.allUrls,
    required this.startIndex,
  });

  final List<ContentNode> nodes;
  final List<String> allUrls;
  final int startIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (nodes.length == 1) {
          final node = nodes.first;
          final ratio =
              (node.width != null && node.height != null && node.height! > 0)
              ? node.width! / node.height!
              : 4 / 3;
          final desiredWidth = width > 280 ? 280.0 : width;
          final height = (desiredWidth / ratio).clamp(120.0, 320.0);
          return Align(
            alignment: Alignment.centerLeft,
            child: _tile(
              context,
              url: node.imageUrl!,
              width: desiredWidth,
              height: height,
              index: startIndex,
            ),
          );
        }

        final count = nodes.length;
        final columns = count == 2 ? 2 : 3;
        final spacing = 5.0;
        final tileWidth = (width - spacing * (columns - 1)) / columns;
        final rows = (count / columns).ceil();
        final tileHeight = count == 2 ? tileWidth * 0.72 : tileWidth;
        return SizedBox(
          height: rows * tileHeight + (rows - 1) * spacing,
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: <Widget>[
              for (var i = 0; i < count; i++)
                _tile(
                  context,
                  url: nodes[i].imageUrl!,
                  width: tileWidth,
                  height: tileHeight,
                  index: startIndex + i,
                  overlay: i == 2 && allUrls.length > 3
                      ? '+${allUrls.length - 3}'
                      : null,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _tile(
    BuildContext context, {
    required String url,
    required double width,
    required double height,
    required int index,
    String? overlay,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => PhotoViewPage(urls: allUrls, initialIndex: index),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Hero(
                tag: imageHeroTag(url, index),
                child: CachedNetworkImage(
                  imageUrl: url,
                  cacheManager: FeibaImageCache.managerFor(url),
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
                        size: 22,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
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
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
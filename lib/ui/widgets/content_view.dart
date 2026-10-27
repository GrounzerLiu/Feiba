import 'package:flutter/material.dart';

import '../../data/models/content_node.dart';

/// Renders Tieba rich content: text runs, links, emoticons and inline images.
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
    final baseStyle = style ??
        theme.textTheme.bodyMedium?.copyWith(height: 1.5) ??
        const TextStyle();

    final blocks = <Widget>[];
    var inline = <InlineSpan>[];
    var imageCount = 0;

    void flushInline() {
      if (inline.isEmpty) return;
      blocks.add(Text.rich(TextSpan(style: baseStyle, children: inline)));
      inline = <InlineSpan>[];
    }

    for (final node in nodes) {
      if (node.isImage) {
        if (imageCount >= maxImages) continue;
        imageCount++;
        flushInline();
        blocks.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: _ContentImage(url: node.imageUrl!, width: node.width, height: node.height),
        ));
        continue;
      }

      if (node.isEmoticon) {
        final url = node.emoticonUrl;
        if (url != null) {
          inline.add(WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Image.network(
                url,
                width: 22,
                height: 22,
                errorBuilder: (_, _, _) => Text(node.text, style: baseStyle),
              ),
            ),
          ));
        }
        continue;
      }

      if (node.isLink) {
        inline.add(TextSpan(
          text: node.text,
          style: baseStyle.copyWith(color: theme.colorScheme.primary),
        ));
        continue;
      }

      if (node.text.isNotEmpty) {
        inline.add(TextSpan(text: node.text, style: baseStyle));
      }
    }
    flushInline();

    if (blocks.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: blocks,
    );
  }
}

class _ContentImage extends StatelessWidget {
  const _ContentImage({required this.url, this.width, this.height});

  final String url;
  final int? width;
  final int? height;

  @override
  Widget build(BuildContext context) {
    double? aspect;
    if (width != null && height != null && width! > 0 && height! > 0) {
      aspect = width! / height!;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          height: 120,
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Icon(Icons.broken_image_outlined, size: 32),
        ),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return AspectRatio(
            aspectRatio: aspect ?? 4 / 3,
            child: Container(
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
      ),
    );
  }
}

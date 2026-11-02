import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/image_cache.dart';
import '../../data/models/content_node.dart';
import '../video_page.dart';

/// A video cover with a play overlay; tapping opens the media_kit player.
class VideoThumb extends StatelessWidget {
  const VideoThumb({
    super.key,
    required this.node,
    this.maxWidth = 360,
    this.maxHeight = 280,
  });

  final ContentNode node;
  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cover = node.videoCover;
    final duration = _durationText(node.videoDuration);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.clamp(0.0, maxWidth);
        final ratio =
            (node.width != null && node.height != null && node.height! > 0)
            ? node.width! / node.height!
            : 16 / 9;
        final height = (width / ratio).clamp(150.0, maxHeight);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => VideoPage(
                url: node.videoUrl!,
                title: '视频',
                coverUrl: cover,
              ),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: width,
              height: height,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  if (cover != null && cover.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: cover,
                      cacheManager: FeibaImageCache.managerFor(cover),
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                      ),
                    )
                  else
                    Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                    ),
                  Container(color: Colors.black.withValues(alpha: 0.22)),
                  const Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  if (duration.isNotEmpty)
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          duration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _durationText(int seconds) {
    if (seconds <= 0) return '';
    final minutes = seconds ~/ 60;
    final remainder = (seconds % 60).toString().padLeft(2, '0');
    return '${minutes.toString().padLeft(2, '0')}:$remainder';
  }
}

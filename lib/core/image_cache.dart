import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Disk cache policy for remote images.
///
/// Tieba image URLs usually carry a version marker (tbpicau) or query v/sign.
/// For those URLs the cache key already changes when the image changes, so
/// entries get a very long lifetime. Avatars without a version marker use the
/// seven-day TTL so an updated avatar is eventually picked up even if its URL
/// stays the same.
class FeibaImageCache {
  FeibaImageCache._();

  static final CacheManager stable = CacheManager(
    Config(
      'feiba_stable_images_v1',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 400,
    ),
  );

  static final CacheManager versioned = CacheManager(
    Config(
      'feiba_versioned_images_v1',
      stalePeriod: const Duration(days: 3650),
      maxNrOfCacheObjects: 600,
    ),
  );

  static CacheManager managerFor(String url) {
    return isVersioned(url) ? versioned : stable;
  }

  static bool isVersioned(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    if (uri.queryParameters.containsKey('tbpicau')) return true;
    if (uri.queryParameters.keys.any((key) => key == 'sign' || key == 'v')) {
      return true;
    }
    return false;
  }

  static Future<void> clear() async {
    await stable.emptyCache();
    await versioned.emptyCache();
  }
}

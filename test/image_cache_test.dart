import 'package:feiba/core/image_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('versioned Tieba URLs are cached without a short expiry', () {
    expect(
      FeibaImageCache.isVersioned(
        'https://himg.bdimg.com/sys/portrait/item/abc123',
      ),
      isFalse,
    );
    expect(
      FeibaImageCache.isVersioned(
        'https://tiebapic.baidu.com/forum/w%3D120/sign=abc/photo.jpg?tbpicau=2026-11-08',
      ),
      isTrue,
    );
    expect(
      FeibaImageCache.isVersioned('https://example.com/static/logo.jpg'),
      isFalse,
    );
  });
}

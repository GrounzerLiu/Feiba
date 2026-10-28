/// Shared-element tag for an image tile and its full-screen viewer page.
String imageHeroTag(String url, int index) =>
    'image-$index-${url.hashCode}';

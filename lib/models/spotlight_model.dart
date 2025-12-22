import 'package:html/parser.dart' as html;
import 'package:html/dom.dart';

enum SpotlightItemType {
  externalLink,
  download,
  internal,
  unknown,
}

class SpotlightItem {
  final String title;
  final SpotlightItemType type;
  final String url;

  SpotlightItem({
    required this.title,
    required this.type,
    required this.url,
  });

  @override
  String toString() =>
      'SpotlightItem(title: $title, type: $type, url: $url)';
}

import 'package:html/parser.dart' as html;
import 'package:vtapp/session.dart';
import 'package:vtapp/models/spotlight_model.dart';

List<SpotlightItem> parseSpotlight() {
  final document = html.parse(Session.spotlighthtml);
  final selector = document.querySelectorAll('li.list-group-item.py-1');

  List<SpotlightItem> items = [];

  for (final v in selector) {
    final anchor = v.querySelector('a');
    if (anchor == null) continue;

    final title = anchor.text.trim();
    String url = '';
    SpotlightItemType type = SpotlightItemType.unknown;

    // External link
    if (anchor.attributes.containsKey('href') &&
        anchor.attributes['href']!.startsWith('http')) {
      url = anchor.attributes['href']!;
      type = SpotlightItemType.externalLink;
    }

    // Download (onclick)
    else if (anchor.attributes.containsKey('onclick')) {
      final onclick = anchor.attributes['onclick']!;
      final match = RegExp(r"'(.*?)'").firstMatch(onclick);
      if (match != null) {
        url = match.group(1)!;
        type = SpotlightItemType.download;
      }
    }

    // Internal navigation
    else if (anchor.attributes['href'] == 'javascript:void(0);') {
      type = SpotlightItemType.internal;
    }

    items.add(
      SpotlightItem(
        title: title.isEmpty ? 'Untitled' : title,
        type: type,
        url: url,
      ),
    );
  }

  return items;
}

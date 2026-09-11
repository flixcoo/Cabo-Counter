import 'package:cabo_counter/services/icon_service.dart';

class NewsItem {
  final Map<String, String> localizedTitle;
  final Map<String, String> localizedText;
  final AppIcon icon;

  NewsItem({
    required this.localizedTitle,
    required this.localizedText,
    required this.icon,
  });
}

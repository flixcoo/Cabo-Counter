import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/dto/NewsItem.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({required this.newsItem, super.key});

  final NewsItem newsItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(newsItem.icon, color: CustomTheme.primaryColor, size: 32),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newsItem.title,
                style: const TextStyle(
                  color: CustomTheme.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                newsItem.text,
                style: const TextStyle(
                  color: CustomTheme.textColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

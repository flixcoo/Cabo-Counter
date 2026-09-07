import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/dto/NewsItem.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({required this.newsItem, super.key});

  final NewsItem newsItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 18,
      children: [
        // Icon
        SizedBox(width: 50, child: Center(child: newsItem.icon)),

        // Text
        Expanded(
          child: Column(
            spacing: 6,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                newsItem.title,
                style: const TextStyle(
                  color: CustomTheme.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Text
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

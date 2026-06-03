import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:flutter/material.dart';

class LicenseTile extends StatefulWidget {
  const LicenseTile({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });

  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  State<LicenseTile> createState() => _LicenseTileState();
}

class _LicenseTileState extends State<LicenseTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
        decoration: BoxDecoration(
          color: CustomTheme.mainElementColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  IconService.license,
                  size: 28,
                  color: CustomTheme.primaryColor,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CustomTheme.textColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        widget.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconService.chevron,
          ],
        ),
      ),
    );
  }
}

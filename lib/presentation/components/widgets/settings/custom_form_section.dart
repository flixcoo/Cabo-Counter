import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/settings/custom_form_row.dart';
import 'package:flutter/material.dart';

class CustomFormSection extends StatelessWidget {
  const CustomFormSection({
    super.key,
    required this.rows,
    this.infoText,
    this.title,
  });

  final List<CustomFormRow> rows;
  final String? infoText;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(title!, style: CustomTheme.rowTitle),
          ),
        ],
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: Container(
            decoration: BoxDecoration(
              color: CustomTheme.settingsTilecolor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < rows.length; i++) ...[
                  rows[i],
                  if (i < rows.length - 1)
                    Divider(
                      height: 1,
                      thickness: 2,
                      color: CustomTheme.white.withAlpha(30),
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
                if (infoText != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                      left: 12,
                      right: 12,
                    ),
                    child: Text(
                      infoText!,
                      style: TextStyle(
                        color: CustomTheme.white.withAlpha(150),
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MainMenuSkeleton extends StatelessWidget {
  const MainMenuSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CupertinoColors.systemGrey2.withValues(alpha: 0.5),
      highlightColor: CupertinoColors.systemGrey2.withValues(alpha: 2),
      child: ListView.separated(
        itemCount: 9,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 0.5,
          color: CustomTheme.white.withAlpha(50),
          indent: 50,
          endIndent: 50,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CupertinoListTile(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                title: Container(
                  width: 170,
                  height: 25,
                  decoration: BoxDecoration(
                    color: CustomTheme.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                subtitle: Container(
                  width: 120,
                  height: 15,
                  decoration: BoxDecoration(
                    color: CustomTheme.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 15,
                      height: 25,
                      decoration: BoxDecoration(
                        color: CustomTheme.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: CustomTheme.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 15,
                      height: 25,
                      decoration: BoxDecoration(
                        color: CustomTheme.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: CustomTheme.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}

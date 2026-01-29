import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/active_game/active_game_list_tile.dart';
import 'package:flutter/material.dart';

class ActiveGameListSet extends StatefulWidget {
  const ActiveGameListSet({
    super.key,
    required this.title,
    required this.content,
    this.tilePadding,
  });

  final String title;

  final EdgeInsets? tilePadding;

  final List<ActiveGameListTile> content;

  @override
  State<ActiveGameListSet> createState() => _ActivegamelistsetState();
}

class _ActivegamelistsetState extends State<ActiveGameListSet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.title, style: CustomTheme.rowTitle),
          ),
          for (var tile in widget.content)
            Padding(
              padding:
                  widget.tilePadding ??
                  const EdgeInsets.fromLTRB(16, 12, 12, 12),
              child: tile,
            ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

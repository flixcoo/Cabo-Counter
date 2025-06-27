import 'package:cabo_counter/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class GraphView extends StatefulWidget {
  const GraphView({super.key});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).game_statistics),
        previousPageTitle: AppLocalizations.of(context).back,
      ),
      child: const Center(child: Text('GraphView')),
    );
  }
}

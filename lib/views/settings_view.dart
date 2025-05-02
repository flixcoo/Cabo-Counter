import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Einstellungen'),
      ),
      child: SafeArea(
          child: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Icon(
                CupertinoIcons.settings,
                size: 100,
              )),
            ],
          ),
          Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: FutureBuilder<PackageInfo>(
                future: _getPackageInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Alpha ${snapshot.data!.version} '
                      '(Build ${snapshot.data!.buildNumber})',
                      textAlign: TextAlign.center,
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'App-Version -.-.- (Build -)',
                      textAlign: TextAlign.center,
                    );
                  }
                  return const Text(
                    'Lade Version...',
                    textAlign: TextAlign.center,
                  );
                },
              )),
        ],
      )),
    );
  }

  Future<PackageInfo> _getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }
}

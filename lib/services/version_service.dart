import 'package:cabo_counter/utility/globals.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionService {
  static String _version = '-.-.-';
  static String _buildNumber = '-';

  static Future<void> init() async {
    var packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
  }

  static String getVersionNumber() {
    return _version;
  }

  static String getVersion() {
    if (_version == '-.-.-') {
      return getVersionNumber();
    }
    return '${Globals.appDevPhase} $_version';
  }

  static String getBuildNumber() {
    return _buildNumber;
  }

  static String getVersionWithBuild() {
    return '$_version ($_buildNumber)';
  }
}

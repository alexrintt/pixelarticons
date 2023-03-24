import 'package:pixelarticons_autoupdate/tools/check_for_updates.dart';

import './package_pubspec.dart';

const _kPackagePubspecVersionKey = 'version';

Future<String> getCurrentPackageVersion() async {
  return getPackagePubspecKey<String>(_kPackagePubspecVersionKey);
}

Future<String> getNextPackageVersion() async {
  final String current = await getCurrentPackageVersion();
  final List<int> version = current.split('.').map(int.parse).toList();
  final int major = version[0];
  final int minor = version[1];
  return '$major.${minor + 1}.0';
}

Future<String> resolveOfficialPackageVersion() async {
  final bool hasUpdate = await hasUpdateAvailable();

  final String packageVersion = hasUpdate
      ? await getNextPackageVersion()
      : await getCurrentPackageVersion();

  return packageVersion;
}

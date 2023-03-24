import './tools/add_commit_msg_to_changelog.dart';
import './tools/check_for_updates.dart';
import './tools/package_pubspec.dart';
import './tools/package_version.dart';
import './tools/pixelarticons_version.dart';

Future<void> main() async {
  if (!await hasUpdateAvailable()) return;

  final String nextPackageVersion = await getNextPackageVersion();
  final String nextPixelarticonsVersion = await getLatestPixelarticonsVersion();

  await setPackagePubspecKey('version', nextPackageVersion);
  await setPackagePubspecKey('pixelarticons_version', nextPixelarticonsVersion);

  await addCommitMsgToChangelog();
}

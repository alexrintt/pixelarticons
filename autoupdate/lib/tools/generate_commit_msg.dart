import './package_version.dart';
import './pixelarticons_version.dart';

Future<String> generateNewVersionCommitMsg() async {
  final String packageVersion = await resolveOfficialPackageVersion();

  final String pixelarticonsVersion = await getLatestPixelarticonsVersion();
  final String pixelarticonsReleaseUrl =
      await getLatestPixelarticonsReleaseUrl();
  final String pixelarticonsReleaseDate = await getPixelarticonsReleaseDate();

  return 'Automatic package roolup `v$packageVersion` of Pixel Art Icons `$pixelarticonsVersion`, source release available at $pixelarticonsReleaseUrl published at $pixelarticonsReleaseDate';
}

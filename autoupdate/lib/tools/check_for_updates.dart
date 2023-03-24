import 'pixelarticons_version.dart';

/// Returns [true] if there's a new [pixelarticons] update available (new unreleased icon pack)
Future<bool> hasUpdateAvailable() async {
  final String current = await getCurrentPixelarticonsVersion();
  final String latest = await getLatestPixelarticonsVersion();
  return current != latest;
}

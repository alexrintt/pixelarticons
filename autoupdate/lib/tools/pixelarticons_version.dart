import 'dart:convert';
import 'package:http/http.dart' as http;

import './package_pubspec.dart';

const _kPixelarticonsPubspecConfigKey = 'pixelarticons_version';
const _kPixelarticonsRepositoryReleasesEndpoint =
    'https://api.github.com/repos/halfmage/pixelarticons/releases/latest';

Future<String> getCurrentPixelarticonsVersion() async {
  return getPackagePubspecKey<String>(_kPixelarticonsPubspecConfigKey);
}

Future<Map<String, dynamic>> _fetchLatestPixelarticonsRelease() async {
  final http.Response response =
      await http.get(Uri.parse(_kPixelarticonsRepositoryReleasesEndpoint));

  final Map<String, dynamic> data =
      jsonDecode(response.body) as Map<String, dynamic>;

  return data;
}

Future<String> getLatestPixelarticonsVersion() async {
  final Map<String, dynamic> data = await _fetchLatestPixelarticonsRelease();

  return data['tag_name'] as String;
}

Future<String> getPixelarticonsReleaseDate() async {
  final Map<String, dynamic> data = await _fetchLatestPixelarticonsRelease();

  return data['published_at'] as String;
}

Future<String> getLatestPixelarticonsReleaseUrl() async {
  final Map<String, dynamic> data = await _fetchLatestPixelarticonsRelease();

  return data['html_url'] as String;
}

Future<String> getLatestPixelarticonsReleaseBody() async {
  final Map<String, dynamic> data = await _fetchLatestPixelarticonsRelease();

  return data['body'] as String? ?? '';
}

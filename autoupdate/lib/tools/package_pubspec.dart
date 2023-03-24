import 'dart:io';
import 'package:yaml/yaml.dart';

File get pubspecFile => File('./pubspec.yaml');

Future<String> getPubspecContent() async {
  return pubspecFile.readAsStringSync();
}

Future<void> setPubspecContent(String contents) async {
  return pubspecFile.writeAsStringSync(contents);
}

Future<Map<String, dynamic>> getPackagePubspecFileData() async {
  final YamlMap contents = loadYaml(await getPubspecContent()) as YamlMap;
  return Map<String, dynamic>.from(contents);
}

Future<T> getPackagePubspecKey<T>(String key) async {
  final Map<String, dynamic> fileData = await getPackagePubspecFileData();

  return fileData[key] as T;
}

Future<void> setPackagePubspecKey(String key, String value) async {
  String lineMapper(String line) {
    final RegExp emptySpace = RegExp(r'\s');

    if (line.isEmpty || line.startsWith(emptySpace)) return line;

    const kYamlKeyValueSeparator = ':';

    final List<String> spplited = line.split(kYamlKeyValueSeparator);

    final String k = spplited.take(1).join().trim();
    final String v = spplited.skip(1).join(kYamlKeyValueSeparator).trim();

    // We ignore multiline keys due complexity purposes, we don't need such a
    // thing to update a simple [key: value], otherwise we were creating a new
    // yaml parsing library. Also we aren't using it because the package [yaml_writer]
    // showed indent and key bugs in the output.
    if (v.isEmpty) return line;

    return k == key ? '$key: $value' : '$k: $v';
  }

  final String fileContent = await getPubspecContent();
  final List<String> lines = fileContent.split('\n');

  await setPubspecContent(lines.map(lineMapper).join('\n'));
}

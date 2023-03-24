import 'dart:io';

import './tools/check_for_updates.dart';

const kHasNewReleaseActionKey = 'update_available';

Future<void> main() async {
  final bool hasUpdate = await hasUpdateAvailable();

  stdout.write('::set-output name=$kHasNewReleaseActionKey::$hasUpdate');
}

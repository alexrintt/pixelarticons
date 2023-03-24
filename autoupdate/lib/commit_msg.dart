import 'dart:io';

import './tools/generate_commit_msg.dart';

const kReleaseCommitMsgActionKey = 'new_release_commit_msg';

Future<void> main() async {
  final String msg = await generateNewVersionCommitMsg();

  stdout.write('::set-output name=$kReleaseCommitMsgActionKey::$msg');
}

import 'package:dcli/dcli.dart' show cyan;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

void diskenv() {
  clear();

  print(cyan(lang(35)));

  chooser(lang(33), [lang(36), lang(37)])
      .map(
        (final sel) =>
            sel == lang(36) ? diskenvdev = 'HDD' : diskenvdev = 'SSD',
      )
      .run();
}

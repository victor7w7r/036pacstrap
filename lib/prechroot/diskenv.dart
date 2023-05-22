import 'package:dcli/dcli.dart' show cyan;

import 'package:pacstrap/pacstrap.dart';

void diskenv() {

  clear();

  print(cyan(lang(35)));

  chooser(lang(33), [lang(36), lang(37)])
    .map((sel) => sel == lang(36)
      ? diskenvdev = 'HDD'
      : diskenvdev = 'SSD')
    .run();

}
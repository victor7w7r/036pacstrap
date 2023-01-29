import 'package:console/console.dart' show Chooser;
import 'package:dcli/dcli.dart' show cyan;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:pacstrap/index.dart';

void diskenv() {

  clear();

  print(cyan(lang(35)));

  IO(Chooser<String>([lang(36), lang(37)], message: lang(33)).chooseSync)
    .map((sel) => sel == lang(36)
      ? locator.get<App>().diskenv = "HDD"
      : locator.get<App>().diskenv = "SSD"
    )
    .run();

}
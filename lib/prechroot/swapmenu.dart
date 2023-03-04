import 'dart:io';

import 'package:console/console.dart' show Chooser;
import 'package:dcli/dcli.dart' show cyan;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:pacstrap/index.dart';

Future<void> swapmenu() async {

  final app = locator.get<App>();

  clear();

  if(app.diskenv == 'HDD') {

    int count = 0;
    int countMount = 0;

    List<String> verify = [];
    List<String> swapParts = [];

    if(RegExp(r'sd[A-Za-z]').hasMatch(app.disk)){
      verify = await syssplit("find ${app.disk}* | sed '/[[:alpha:]]\$/d'");
    } else if(RegExp(r'mmcblk[0-9_-]').hasMatch(app.disk)) {
      verify = await syssplit("find ${app.disk}* | sed '/k[[:digit:]]\$/d'");
    } else if(RegExp(r'nvme[0-9_-]').hasMatch(app.disk)) {
      verify = await syssplit("find ${app.disk}* | sed '/e[[:digit:]]\$/d'");
    }

    for(final part in verify) {
      if(part != locator.get<App>().efipart && part != locator.get<App>().rootpart) {
        await sysout("lsblk $part | sed -ne '/\\//p'") != ''
          ? countMount++
          : swapParts.add(part);
        count++;
      }
    }

    if(countMount == count) {
      clear();
      lang(17, PrintQuery.error);
      exit(1);
    }

    print(cyan(lang(43)));

    IO(Chooser<String>(swapParts, message: lang(33)).chooseSync)
      .map((sel) => locator.get<App>().swappart = sel)
      .run();
  }
}
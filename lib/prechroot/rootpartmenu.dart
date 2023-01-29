import 'dart:io' show exit;

import 'package:console/console.dart' show Chooser;
import 'package:dcli/dcli.dart' show cyan;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:pacstrap/index.dart';

Future<void> rootpartmenu() async {

  final disk = locator.get<App>().disk;

  clear();

  int count = 0;
  int countMount = 0;

  final verify = <String>[];
  final rootParts = <String>[];

  final efipart = await sysoutwline('fdisk -l $disk | sed -ne /EFI/p | cut -d " " -f1');

  if(RegExp(r'sd[A-Za-z]').hasMatch(disk)) {
    verify.addAll(await syssplit("find $disk* | sed '/[[:alpha:]]\$/d'"));
  } else if(RegExp(r'mmcblk[0-9_-]').hasMatch(disk)) {
    verify.addAll(await syssplit("find $disk* | sed '/k[[:digit:]]\$/d'"));
  } else if(RegExp(r'nvme[0-9_-]').hasMatch(disk)) {
    verify.addAll(await syssplit("find $disk* | sed '/e[[:digit:]]n[[:digit:]]\$/d'"));
  }

  for(final part in verify) {
    if(part != efipart) {
      if(await sysout("lsblk $part | sed -ne '/\\//p'") != "") {
        countMount++;
      } else {
        rootParts.add(part);
      }
      count++;
    }
  }

  if(countMount == count) {
    clear();
    lang(17, PrintQuery.error);
    exit(1);
  }

  locator.get<App>().efipart = efipart;

  print(cyan(lang(42)));

  IO(Chooser<String>(rootParts, message: lang(33)).chooseSync)
    .map((sel) => locator.get<App>().rootpart = sel)
    .run();

}
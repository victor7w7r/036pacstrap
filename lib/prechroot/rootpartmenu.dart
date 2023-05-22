import 'dart:io' show exit;

import 'package:dcli/dcli.dart' show cyan;

import 'package:pacstrap/pacstrap.dart';

Future<void> rootpartmenu() async {

  clear();

  var ( count, countMount ) = ( 0, 0 );

  final ( verify, rootParts ) = ( <String>[], <String>[] );

  final efipartquery = await syswline(
    'fdisk -l $disk | sed -ne /EFI/p | cut -d " " -f1'
  );

  if(RegExp(r'sd[A-Za-z]').hasMatch(disk)) {
    verify.addAll(await syssplit(
      "find $disk* | sed '/[[:alpha:]]\$/d'"
    ));
  } else if(RegExp(r'mmcblk[0-9_-]').hasMatch(disk)) {
    verify.addAll(await syssplit(
      "find $disk* | sed '/k[[:digit:]]\$/d'"
    ));
  } else if(RegExp(r'nvme[0-9_-]').hasMatch(disk)) {
    verify.addAll(await syssplit(
      "find $disk* | sed '/e[[:digit:]]n[[:digit:]]\$/d'"
    ));
  }

  for(final part in verify) {
    if(part != efipartquery) {
      (await sys("lsblk $part | sed -ne '/\\//p'") != '')
        ? countMount++
        : rootParts.add(part);
      count++;
    }
  }

  if(countMount == count) {
    clear();
    lang(17, PrintQuery.error);
    exit(1);
  }

  efipart = efipartquery;

  print(cyan(lang(42)));

  chooser(lang(33), rootParts)
    .map((sel) => rootpart = sel)
    .run();

}
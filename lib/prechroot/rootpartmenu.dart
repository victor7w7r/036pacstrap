import 'dart:io' show exit;

import 'package:dcli/dcli.dart' show cyan;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> rootpartmenu() async {

  clear();

  var ( count, countMount ) = ( 0, 0 );

  final ( verify, rootParts ) = ( <String>[], <String>[] );

  final efipartquery = await syswline(
    'fdisk -l $disk | sed -ne /EFI/p | cut -d " " -f1'
  );

  if(RegExp('sd[A-Za-z]').hasMatch(disk)) {
    verify.addAll(await syssplit(
      "find $disk* | sed '/[[:alpha:]]\$/d'"
    ));
  } else if(RegExp('mmcblk[0-9_-]').hasMatch(disk)) {
    verify.addAll(await syssplit(
      "find $disk* | sed '/k[[:digit:]]\$/d'"
    ));
  } else if(RegExp('nvme[0-9_-]').hasMatch(disk)) {
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
    .map((final sel) => rootpart = sel)
    .run();

}

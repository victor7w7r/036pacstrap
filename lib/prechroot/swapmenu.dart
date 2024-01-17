import 'dart:io' show exit;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> swapmenu() async {
  clear();

  if (diskenvdev == 'HDD') {
    var (count, countMount) = (0, 0);

    final (verify, swapParts) = (<String>[], <String>[]);

    if (RegExp('sd[A-Za-z]').hasMatch(disk)) {
      verify.addAll(await syssplit("find $disk* | sed '/[[:alpha:]]\$/d'"));
    } else if (RegExp('mmcblk[0-9_-]').hasMatch(disk)) {
      verify.addAll(await syssplit("find $disk* | sed '/k[[:digit:]]\$/d'"));
    } else if (RegExp('nvme[0-9_-]').hasMatch(disk)) {
      verify.addAll(await syssplit("find $disk* | sed '/e[[:digit:]]\$/d'"));
    }

    for (final part in verify) {
      if (part != efipart && part != rootpart) {
        await sys("lsblk $part | sed -ne '/\\//p'") != ''
            ? countMount++
            : swapParts.add(part);
        count++;
      }
    }

    if (countMount == count) {
      clear();
      lang(17, PrintQuery.error);
      exit(1);
    }

    cyan(lang(43));

    chooser(lang(33), swapParts).map((final sel) => swappart = sel).run();
  }
}

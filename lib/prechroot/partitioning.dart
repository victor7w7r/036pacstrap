import 'dart:async' show unawaited;
import 'dart:io' show exit;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/prechroot/diskformat.dart';
import 'package:pacstrap/pacstrap.dart';

List<String> _linuxParts(final List<String> partCodes) {
  var count = 1;

  final result = <String>[];

  for (final code in partCodes) {
    if (code == '8300') result.add('$disk$count');
    count++;
  }

  return result;
}

Future<void> _menuPartitioning(
  final String sel,
  final String partCodes,
) async {
  final efiSize = await sys('export LANG=C; '
      'sudo parted -s $disk unit MiB p '
      "| awk '{ if (\$3 == \"End\") { flag=1 } if (flag) { print \$3 } }' "
      "| sed -ne '2p'; "
      'export LANG= ');

  if (sel == lang(20)) {
    clear();
    await coderes('cgdisk $disk');
    unawaited(partitioning());
  } else if (sel == lang(21)) {
    clear();
    await coderes('parted $disk');
    unawaited(partitioning());
  } else if (sel == lang(22)) {
    await call('parted -s $disk unit MiB mkpart primary '
        '${diskenvdev == 'SSD' ? 'f2fs' : 'ext4'} $efiSize 100%');
    rootpart = '${disk}2';
    unawaited(diskformat(partCodes));
  } else if (sel == lang(23)) {
    exit(0);
  } else {
    rootpart = sel;
    unawaited(diskformat(partCodes));
  }
}

Future<void> partitioning() async {
  clear();

  final partCodes = await syssplit('export LANG=C; '
      'sudo gdisk -l $disk '
      "| awk '{ if (\$6 == \"Size\") { flag=1 } if (flag) { print \$6 } }' "
      "| sed '1d'; "
      'export LANG= ');

  if (!partCodes.contains('8300')) {
    cyan(lang(19));
    red(lang(26));
    await chooser(lang(13), [
      lang(20),
      lang(21),
      lang(22),
      lang(23),
    ]).map((final sel) => _menuPartitioning(sel, partCodes)).run();
  } else {
    cyan(lang(24));
    red(lang(26));
    await chooser(lang(13), [
      ..._linuxParts(partCodes),
      lang(20),
      lang(21),
      lang(22),
      lang(23),
    ]).map((final sel) => _menuPartitioning(sel, partCodes)).run();
  }
}

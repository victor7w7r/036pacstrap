import 'dart:io' show exit;

import 'package:dcli/dcli.dart' show cyan;

import 'package:pacstrap/pacstrap.dart';

Future<List<String>> _devs() => syssplit(
  'find /dev/disk/by-path/ '
  r"| sed 's/^\/dev\/disk\/by-path\///'"
);

Future<String> _dirtyDev(
  final String dev
) => syswline('readlink "/dev/disk/by-path/$dev"');

Future<String> _absoluteDev(
  final String dev
) => sys(
  'echo $dev '
  "| sed 's/^\\.\\.\\/\\.\\.\\//\\/dev\\//' "
  "| sed '/.*[[:alpha:]]\$/d' | sed '/blk[[:digit:]]\$/d' "
  "| sed '/nvme[[:digit:]]n[[:digit:]]\$/d'"
);

Future<String> _blockDev(
  final String dev
) => syswline("echo $dev | sed 's/^\\.\\.\\/\\.\\.\\///'");

Future<String> diskmenu() async {

  clear();

  var count = 0;

  final (block, dirtyDevs, array) = (
    <String>[], <String>[], <String>[]
  );

  for (final dev in await _devs()) {
    dirtyDevs.add(await _dirtyDev(dev));
    count++;
  }

  dirtyDevs.removeWhere((dev) => dev == '');

  if(count == 0){
    lang(11, PrintQuery.normal);
    exit(1);
  }

  for (final dev in dirtyDevs) {
    await _absoluteDev(dev) == ''
      ? block.add(await _blockDev(dev))
      : {};
  }

  for(final part in block) {
    array.add('/dev/$part');
  }

  print(cyan(lang(41)));

  return chooser(lang(33), array).run();
}
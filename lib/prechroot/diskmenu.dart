import 'dart:io' show exit;

import 'package:console/console.dart' show Chooser;
import 'package:dcli/dcli.dart' show cyan;

import 'package:pacstrap/index.dart';

Future<List<String>> _devs() =>
  syssplit(r"find /dev/disk/by-path/ | sed 's/^\/dev\/disk\/by-path\///'");

Future<String> _dirtyDev(String dev) =>
  sysoutwline('readlink "/dev/disk/by-path/$dev"');

Future<String> _absoluteDev(String dev) =>
  sysout("echo $dev | sed 's/^\\.\\.\\/\\.\\.\\//\\/dev\\//' | sed '/.*[[:alpha:]]\$/d' | sed '/blk[[:digit:]]\$/d' | sed '/nvme[[:digit:]]n[[:digit:]]\$/d'");

Future<String> _blockDev(String dev) =>
  sysoutwline("echo $dev | sed 's/^\\.\\.\\/\\.\\.\\///'");

Future<String> diskmenu() async {

  clear();

  int count = 0;

  final block = <String>[];
  final dirtyDevs = <String>[];
  final array = <String>[];

  for (final dev in await _devs()) {
    dirtyDevs.add(await _dirtyDev(dev));
    count++;
  }

  dirtyDevs.removeWhere((e) => e == '');

  if(count == 0){
    lang(11, PrintQuery.normal);
    exit(1);
  }

  for (final dev in dirtyDevs) {
    final abs = await _absoluteDev(dev);
    abs == ''
      ? block.add(await _blockDev(dev))
      : {};
  }

  for(final part in block) {
    array.add('/dev/$part');
  }

  print(cyan(lang(41)));

  return Chooser<String>(array, message: lang(33)).chooseSync();
}
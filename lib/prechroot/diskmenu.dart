import 'dart:io' show exit;

import 'package:dcli/dcli.dart' show cyan;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

Future<String> _allAbsoluteDev(
  final String dev
) => sys(
  'echo $dev '
  r"| sed 's/^\.\.\/\.\.\//\/dev\//' "
  r"| sed '/.*[[:alpha:]]$/d' | sed '/blk[[:digit:]]$/d' "
  r"| sed '/nvme[[:digit:]]n[[:digit:]]$/d'"
);

Future<String> diskmenu() async {

  clear();

  var count = 0;

  final (block, dirtyDevs, array) = (
    <String>[], <String>[], <String>[]
  );

  for (final dev in await allDevs()) {
    dirtyDevs.add(await dirtyDev(dev));
    count++;
  }

  dirtyDevs.removeWhere((final dev) => dev == '');

  if(count == 0){
    lang(11, PrintQuery.normal);
    exit(1);
  }

  for (final dev in dirtyDevs) {
    if(await _allAbsoluteDev(dev) == '') block.add(await getBlockDev(dev));
  }

  for(final part in block) {
    array.add('/dev/$part');
  }

  print(cyan(lang(41)));

  return chooser(lang(33), array).run();
}

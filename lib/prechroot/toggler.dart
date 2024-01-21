import 'dart:io' show Directory;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> toggler() async {
  clear();
  header('CHROOT');

  await call('cp ${Directory.current.path}/pacstrap /mnt/pacstrap');
  await call('chmod +x /mnt/pacstrap');
  await coderes(
    'arch-chroot /mnt ./pacstrap chroot $diskenvdev ${english ? 1 : 0}',
  );

  lang(28, PrintQuery.normal);
  await call('rm -f /mnt/pacstrap &> /dev/null');
}

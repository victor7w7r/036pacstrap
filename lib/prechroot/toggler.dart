import 'dart:io' show Directory;

import 'package:pacstrap/index.dart';

Future<void> toggler() async {

  final app = locator.get<App>();

  clear();
  print('=============== CHROOT =============== \n');

  await syscall('cp ${Directory.current.path}/pacstrap /mnt/pacstrap');
  await syscall('chmod +x /mnt/pacstrap');
  await codeproc('arch-chroot /mnt ./pacstrap chroot ${app.diskenv} ${app.english ? 1 : 0}');

  lang(24, PrintQuery.normal);
  await syscall('rm -f /mnt/pacstrap &> /dev/null');
}
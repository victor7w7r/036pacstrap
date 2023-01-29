import 'dart:io' show File, FileMode, stdin;

import 'package:pacstrap/index.dart';

Future<void> optimizations() async {

  clear();
  lang(31, PrintQuery.normal);

  await codeproc("""sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=0 nowatchdog"/' /etc/default/grub &> /dev/null""");
  await codeproc("grub-mkconfig -o /boot/grub/grub.cfg");
  await syscall("systemctl mask lvm2-monitor");
  await syscall("touch /etc/modprobe.d/blacklists.conf");

  File('/etc/modprobe.d/blacklists.conf')
    .writeAsStringSync('blacklist iTCO_wdt\nblacklist joydev\nblacklist mousedev\nblacklist mac_hid', mode: FileMode.write);

  print("");
  print("=============== OK =============== \n");
  print(lang(45));
  stdin.readLineSync();
}
import 'dart:io' show File;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> optimizations() async {
  clear();
  lang(31, PrintQuery.normal);

  await coderes(
      """sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=0 nowatchdog"/' /etc/default/grub &> /dev/null""");
  await coderes('grub-mkconfig -o /boot/grub/grub.cfg');
  await call('systemctl mask lvm2-monitor');
  await call('touch /etc/modprobe.d/blacklists.conf');

  File('/etc/modprobe.d/blacklists.conf').writeAsStringSync(
    'blacklist iTCO_wdt\n'
    'blacklist joydev\n'
    'blacklist mousedev\nblacklist mac_hid',
  );

  okMessage();
}

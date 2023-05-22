import 'dart:io' show File, FileMode;

import 'package:pacstrap/pacstrap.dart';

Future<void> swapper() async {

  clear();
  header('SWAPPING');

  if(diskenvdev == 'HDD') {
    File('/etc/sysctl.d/99-sysctl.conf')
      .writeAsStringSync('vm.swappiness=60',
      mode: FileMode.append
    );
  } else {
    await coderes("sudo -u $sudouser bash -c 'cd; git clone https://aur.archlinux.org/zramswap.git'");
    await coderes("sudo -u $sudouser bash -c 'cd; cd zramswap; makepkg -si --noconfirm'");
    await call("sudo -u $sudouser bash -c 'cd; rm -rf zramswap'");
    await call('systemctl enable zramswap.service');
  }
  ok();
}
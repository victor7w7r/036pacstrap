import 'dart:io' show File, FileMode, stdin;

import 'package:pacstrap/index.dart';

Future<void> swapper() async {

  final app = locator.get<App>();

  clear();
  print('=============== SWAPPING =============== \n');

  if(app.diskenv == 'HDD') {
    File('/etc/sysctl.d/99-sysctl.conf')
      .writeAsStringSync('vm.swappiness=60', mode: FileMode.append);
  } else {
    await codeproc("sudo -u ${app.sudouser} bash -c 'cd; git clone https://aur.archlinux.org/zramswap.git'");
    await codeproc("sudo -u ${app.sudouser} bash -c 'cd; cd zramswap; makepkg -si --noconfirm'");
    await syscall("sudo -u ${app.sudouser} bash -c 'cd; rm -rf zramswap'");
    await syscall('systemctl enable zramswap.service');
  }
    print('');
    print('=============== OK =============== \n');
    print(lang(45));
    stdin.readLineSync();
}
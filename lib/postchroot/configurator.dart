import 'dart:io' show stdin;

import 'package:console/console.dart' show Chooser;
import 'package:dcli/dcli.dart' show cyan;

import 'package:pacstrap/index.dart';

void _ok() {
  print('');
  print('=============== OK =============== \n');
  print(lang(45));
  stdin.readLineSync();
}

Future<void> configurator() async {
  clear();
  lang(25, PrintQuery.normal);
  await codeproc('passwd');
  _ok();

  clear();

  print(cyan(lang(51)));

  final sel = Chooser<String>(['Intel', 'AMD'], message: lang(33)).chooseSync();

    if(sel == 'Intel') {
      clear();
      print('=============== INTEL MICROCODE  =============== \n');
      await codeproc('pacman -S intel-ucode --noconfirm');
      _ok();
    } else {
      clear();
      print('=============== AMD MICROCODE  =============== \n');
      await codeproc('pacman -S amd-ucode --noconfirm');
      _ok();
    }

  clear();

  lang(26, PrintQuery.normal);

  await codeproc('grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch');
  await codeproc('grub-mkconfig -o /boot/grub/grub.cfg');
  await syscall('umount /boot/efi');

  _ok();

  clear();

  lang(27, PrintQuery.normal);

  await codeproc('systemctl enable NetworkManager');
  await codeproc('systemctl enable sshd');
  await syscall(r"sed -i 's/^#PermitRootLogin\s.*$/PermitRootLogin yes/' /etc/ssh/sshd_config &> /dev/null");

  _ok();

}
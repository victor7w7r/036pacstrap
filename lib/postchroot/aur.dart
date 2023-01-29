import 'dart:io';

import 'package:pacstrap/index.dart';

Future<void> aur() async {

  clear();
  lang(29, PrintQuery.normal);

  await codeproc("pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com");
  await codeproc("pacman-key --lsign-key FBA220DFC880C036");
  await codeproc("pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm");
  await syscall("sed -i \"/\\[multilib\\]/,/Include/\"'s/^//' /etc/pacman.conf");
  File('/etc/pacman.conf')
    .writeAsStringSync(
      '[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n',
      mode: FileMode.append
    );
  await codeproc("pacman -Syyu yay powerpill linux-lqx linux-lqx-headers pamac-aur rate-mirrors --noconfirm");
  await syscall("rate-mirrors --allow-root --protocol https arch | sudo tee /etc/pacman.d/mirrorlist");
  await codeproc("pacman -S --needed base-devel fakeroot packer --noconfirm");

  await codeproc("grub-mkconfig -o /boot/grub/grub.cfg");

  print("");
  print("=============== OK =============== \n");
  print(lang(45));
  stdin.readLineSync();
}
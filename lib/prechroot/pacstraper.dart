import 'dart:io' show stdin;

import 'package:pacstrap/index.dart';

Future<void> pacstraper() async {

  clear();
  lang(22, PrintQuery.normal);

  await codeproc("pacstrap /mnt base linux linux-firmware linux-headers nano sudo vi neovim git wget grub efibootmgr os-prober rsync networkmanager neofetch f2fs-tools base-devel openssh arch-install-scripts screen unrar p7zip zsh dosfstools python");
  await syscall("genfstab -U /mnt >> /mnt/etc/fstab");

  print("");
  print("=============== OK =============== \n");
  print(lang(45));
  stdin.readLineSync();
}
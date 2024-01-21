import 'dart:async' show unawaited;

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/prechroot.dart';

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

Future<void> pacstraper() async {
  clear();
  lang(28, PrintQuery.normal);

  await coderes(
      'pacstrap /mnt base linux linux-firmware linux-headers nano sudo vi '
      'neovim git wget grub efibootmgr os-prober rsync networkmanager neofetch '
      'f2fs-tools base-devel openssh arch-install-scripts screen unrar p7zip '
      'fish dosfstools python');
  await call('genfstab -U /mnt >> /mnt/etc/fstab');

  okMessage();

  unawaited(toggler());
}

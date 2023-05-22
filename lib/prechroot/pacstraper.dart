import 'package:pacstrap/pacstrap.dart';

Future<void> pacstraper() async {

  clear();
  lang(22, PrintQuery.normal);

  await coderes(
    'pacstrap /mnt base linux linux-firmware linux-headers nano sudo vi '
    'neovim git wget grub efibootmgr os-prober rsync networkmanager neofetch '
    'f2fs-tools base-devel openssh arch-install-scripts screen unrar p7zip '
    'zsh dosfstools python'
  );
  await call('genfstab -U /mnt >> /mnt/etc/fstab');

  ok();

}
import 'dart:io' show File;

import 'package:dcli/dcli.dart' show cyan;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> software() async {
  clear();

  File('/etc/X11/Xwrapper.config').writeAsStringSync('allowed_users=anybody');

  print(cyan('${lang(60)} opera'));

  if (stdYesNo()) {
    clear();
    await coderes('pacman -S opera --noconfirm');
    okMessage();
  }

  clear();

  print(cyan('${lang(60)} nodejs, yarn, jdk'));

  if (stdYesNo()) {
    clear();
    await coderes('pacman -S nodejs-lts-gallium yarn jdk11-openjdk '
        'jre11-openjdk jre11-openjdk-headless --noconfirm');
    okMessage();
  }

  clear();

  print(cyan(
      '${lang(60)} balena-etcher, postman, github-desktop, visual-studio-code-bin'));

  if (stdYesNo()) {
    clear();
    await coderes('pacman -S balena-etcher postman github-desktop '
        'visual-studio-code-bin --noconfirm');
    okMessage();
  }

  clear();

  print(cyan('${lang(60)} wine playonlinux vlc exe-thumbnailer'));

  if (stdYesNo()) {
    clear();
    await coderes('pacman -S wine playonlinux vlc '
        'exe-thumbnailer --noconfirm');
    okMessage();
  }

  clear();

  print(cyan('${lang(60)} teamviewer remmina libvncserver'));

  if (stdYesNo()) {
    clear();
    await coderes('pacman -S teamviewer remmina libvncserver --noconfirm');
    okMessage();
  }

  clear();

  print(cyan('${lang(60)} xarchiver discord'));

  if (stdYesNo()) {
    clear();
    await coderes('pacman -S xarchiver discord --noconfirm');
    okMessage();
  }

  clear();

  print(cyan('${lang(60)} baobab ntfs-3g exfat-utils gparted preload'));

  if (stdYesNo()) {
    clear();
    await coderes('pacman -S baobab ntfs-3g exfat-utils '
        'gparted preload --noconfirm');
    okMessage();
  }

  clear();

  print(cyan('${lang(60)} noto-fonts-emoji ttf-dejavu '
      'xorg-fonts-misc noto-color-emoji-fontconfig'));

  if (stdYesNo()) {
    clear();
    await coderes('pacman -S noto-fonts-emoji ttf-dejavu xorg-fonts-misc '
        'noto-color-emoji-fontconfig ttf-cascadia-code --noconfirm');
    okMessage();
  }

  clear();

  print(cyan('${lang(60)} lshw lsb-release smartmontools sl asciiquarium'));

  if (stdYesNo()) {
    clear();
    await coderes('pacman -S lshw lsb-release smartmontools '
        'sl asciiquarium --noconfirm');
    okMessage();
  }
}

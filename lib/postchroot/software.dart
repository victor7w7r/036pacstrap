import 'dart:io' show File, FileMode, stdin;

import 'package:dcli/dcli.dart' show cyan;
import 'package:console/console.dart' show Chooser;

import 'package:pacstrap/index.dart';

void _ok() {
  print('');
  print('=============== OK =============== \n');
  print(lang(45));
  stdin.readLineSync();
}

Future<void> software() async {

  clear();

  File('/etc/X11/Xwrapper.config')
    .writeAsStringSync('allowed_users=anybody', mode: FileMode.write);

  print(cyan('${lang(60)} opera'));

  final selOne = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(selOne == 'Yes' || selOne == 'Si') {
    clear();
    await codeproc('pacman -S opera --noconfirm');
    _ok();
  }

  clear();

  print(cyan('${lang(60)} nodejs, yarn, jdk'));

  final selTwo = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(selTwo == 'Yes' || selTwo == 'Si') {
    clear();
    await codeproc('pacman -S nodejs-lts-gallium yarn jdk11-openjdk jre11-openjdk jre11-openjdk-headless --noconfirm');
    _ok();
  }

  clear();

  print(cyan('${lang(60)} balena-etcher, postman, github-desktop, visual-studio-code-bin'));

  final selThree = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(selThree == 'Yes' || selThree == 'Si') {
    clear();
    await codeproc('pacman -S balena-etcher postman github-desktop visual-studio-code-bin --noconfirm');
    _ok();
  }

  clear();

  print(cyan('${lang(60)} wine playonlinux vlc exe-thumbnailer'));

  final selFour = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(selFour == 'Yes' || selFour == 'Si') {
    clear();
    await codeproc('pacman -S wine playonlinux vlc exe-thumbnailer --noconfirm');
    _ok();
  }

  clear();

  print(cyan('${lang(60)} teamviewer remmina libvncserver'));

  final selFive = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(selFive == 'Yes' || selFive == 'Si') {
    clear();
    await codeproc('pacman -S teamviewer remmina libvncserver --noconfirm');
    _ok();
  }

  clear();

  print(cyan('${lang(60)} xarchiver discord'));

  final selSix = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(selSix == 'Yes' || selSix == 'Si') {
    clear();
    await codeproc('pacman -S xarchiver discord --noconfirm');
    _ok();
  }

  clear();

  print(cyan('${lang(60)} baobab ntfs-3g exfat-utils gparted preload'));

  final selSeven = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(selSeven == 'Yes' || selSeven == 'Si') {
    clear();
    await codeproc('pacman -S baobab ntfs-3g exfat-utils gparted preload --noconfirm');
    _ok();
  }

  clear();

  print(cyan('${lang(60)} noto-fonts-emoji ttf-dejavu xorg-fonts-misc noto-color-emoji-fontconfig'));

  final selEight = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(selEight == 'Yes' || selEight == 'Si') {
    clear();
    await codeproc('pacman -S noto-fonts-emoji ttf-dejavu xorg-fonts-misc noto-color-emoji-fontconfig ttf-cascadia-code --noconfirm');
    _ok();
  }

  clear();

  print(cyan('${lang(60)} lshw lsb-release smartmontools sl asciiquarium'));

  final selNine = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(selNine == 'Yes' || selNine == 'Si') {
    clear();
    await codeproc('pacman -S lshw lsb-release smartmontools sl asciiquarium --noconfirm');
    _ok();
  }
}
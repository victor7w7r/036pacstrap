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

Future<void> graphical() async {

  bool xfce = false;
  clear();
  await dialog('036 Creative Studios',lang(50), '8', '80');
  clear();

  print(cyan(lang(50)));

  final sel = Chooser<String>(['XFCE', 'GNOME', 'Plasma', 'XORG', 'CUTEFISH', 'NOGUI'], message: lang(33)).chooseSync();

  clear();
  if(sel == 'XFCE') {
    print('=============== XFCE =============== \n');
    await codeproc('pacman -S xorg --noconfirm');
    await codeproc('pacman -S xfce4 xfce4-goodies gtk-engines gtk-engine-murrine xdg-user-dirs gvfs network-manager-applet volumeicon firefox gdm grub-customizer --noconfirm');
    await codeproc('systemctl enable gdm.service');
    _ok();
    xfce = true;
  } else if(sel == 'GNOME') {
    print('=============== GNOME =============== \n');
    await codeproc('pacman -S xorg --noconfirm');
    await codeproc('pacman -S gnome gdm gnome-themes-standard network-manager-applet --noconfirm');
    await codeproc('pacman -S firefox grub-customizer --noconfirm');
    await codeproc('systemctl enable gdm.service');
    _ok();
    xfce = false;
  } else if(sel == 'Plasma') {
    print('=============== KDE =============== \n');
    await codeproc('pacman -S xorg --noconfirm');
    await codeproc('pacman -S plasma plasma-wayland-session kde-applications gnome-themes-standard --noconfirm');
    await codeproc('pacman -S network-manager-applet firefox grub-customizer --noconfirm');
    await codeproc('systemctl enable sddm.service');
    _ok();
    xfce = false;
  } else if(sel == 'XORG') {
    print('=============== XORG ONLY =============== \n');
    await codeproc('pacman -S xorg --noconfirm');
    _ok();
    xfce = false;
  } else if(sel == 'CUTEFISH') {
    print('=============== CUTEFISH =============== \n');
    await codeproc('pacman -S xorg --noconfirm');
    await codeproc('pacman -S cutefish --noconfirm');
    _ok();
    xfce = false;
  } else {
    xfce = false;
  }

  locator.get<App>().xfce = xfce;
}
import 'dart:io' show stdin;

import 'package:dcli/dcli.dart' show cyan;
import 'package:console/console.dart' show Chooser;

import 'package:pacstrap/index.dart';

Future<void> xfcetemplate() async {

  final sudouser = locator.get<App>().sudouser;

  clear();

  print(cyan(lang(59)));

  final sel = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(sel == 'Yes' || sel == 'Si') {
    await codeproc('pacman -S gobject-introspection libdbusmenu-gtk2 libdbusmenu-glib libdbusmenu-gtk3 appmenu-gtk-module xfce4-dockbarx-plugin vala-panel-appmenu-registrar vala-panel --noconfirm');
    await codeproc("sudo -u $sudouser bash -c 'yay -S numix-gtk-theme numix-icon-theme-git numix-circle-icon-theme-git xfce4-windowck-plugin vala-panel-appmenu-common-git vala-panel-appmenu-xfce-git --noconfirm'");
    await codeproc('wget https://raw.githubusercontent.com/victor7w7r/036pacstrap/master/.config.tar.xz -O /root/.config.tar.xz');
    await codeproc("bash -c 'cd; tar -xf .config.tar.xz'");
    await syscall('cp -r /root/.config /home/$sudouser/');
    await syscall('chown -R $sudouser:$sudouser /home/$sudouser/.config');

    print('');
    print('=============== OK =============== \n');
    print(lang(45));
    stdin.readLineSync();
  }
}
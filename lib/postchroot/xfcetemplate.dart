import 'package:dcli/dcli.dart' show cyan;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> xfcetemplate() async {

  clear();

  print(cyan(lang(59)));

  if(stdYesNo()) {
    await coderes(
      'pacman -S gobject-introspection libdbusmenu-gtk2 libdbusmenu-glib '
      'libdbusmenu-gtk3 appmenu-gtk-module xfce4-dockbarx-plugin '
      'vala-panel-appmenu-registrar vala-panel --noconfirm'
    );
    await coderes(
      "sudo -u $sudouser bash -c 'yay -S numix-gtk-theme numix-icon-theme-git "
      // ignore: lines_longer_than_80_chars
      'numix-circle-icon-theme-git xfce4-windowck-plugin vala-panel-appmenu-common-git '
      "vala-panel-appmenu-xfce-git --noconfirm'"
    );
    await coderes(
      'wget https://raw.githubusercontent.com/victor7w7r/036pacstrap/master/.config.tar.xz '
      '-O /root/.config.tar.xz'
    );
    await coderes("bash -c 'cd; tar -xf .config.tar.xz'");
    await call('cp -r /root/.config /home/$sudouser/');
    await call('chown -R $sudouser:$sudouser /home/$sudouser/.config');

    okMessage();
  }
}

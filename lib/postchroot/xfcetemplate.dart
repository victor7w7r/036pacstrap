import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> xfcetemplate() async {
  clear();

  cyan(lang(59));

  if (stdYesNo()) {
    await coderes(
        'pacman -S gobject-introspection libdbusmenu-gtk2 libdbusmenu-glib '
        'libdbusmenu-gtk3 appmenu-gtk-module xfce4-dockbarx-plugin '
        'vala-panel-appmenu-registrar vala-panel --noconfirm');
    await coderes(
        // ignore: lines_longer_than_80_chars
        "sudo -u $sudouser bash -c 'yay -S numix-gtk-theme numix-icon-theme-git "
        // ignore: lines_longer_than_80_chars
        'numix-circle-icon-theme-git xfce4-windowck-plugin vala-panel-appmenu-common-git '
        "vala-panel-appmenu-xfce-git --noconfirm'");
    await call('cp -r /root/dotfiles/xfce4 /root/.config/xfce4');
    await call('cp -r /root/dotfiles/xfce4 /home/$sudouser/.config/xfce4');
    await call('cp -r /root/dotfiles/gtk-3.0 /root/.config/gtk-3.0');
    await call('cp -r /root/dotfiles/gtk-3.0 /home/$sudouser/.config/gtk-3.0');
    await call('chown -R $sudouser:$sudouser /home/$sudouser/.config/xfce4');
    await call('chown -R $sudouser:$sudouser /home/$sudouser/.config/gtk-3.0');
    await call('rm -rf /root/dotfiles');
    okMessage();
  }
}

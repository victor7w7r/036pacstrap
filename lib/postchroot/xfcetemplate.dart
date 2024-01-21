import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> xfcetemplate() async {
  clear();

  cyan(lang(43));

  if (stdYesNo()) {
    await coderes('pacman -S catppuccin-gtk-theme-mocha --noconfirm');
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

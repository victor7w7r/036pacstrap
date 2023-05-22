import 'package:dcli/dcli.dart' show cyan;

import 'package:pacstrap/pacstrap.dart';

Future<void> graphical() async {

  var isXfce = false;
  clear();
  await dialog('036 Creative Studios',
    lang(50), '8', '80'
  );
  clear();

  print(cyan(lang(50)));

  final sel = stdChoose([
    'XFCE', 'GNOME', 'Plasma',
    'XORG', 'CUTEFISH', 'NOGUI'
  ]);

  clear();
  if(sel == 'XFCE') {
    print('=============== XFCE =============== \n');
    await coderes('pacman -S xorg --noconfirm');
    await coderes('pacman -S xfce4 xfce4-goodies gtk-engines gtk-engine-murrine '
      'xdg-user-dirs gvfs network-manager-applet '
      'volumeicon firefox gdm grub-customizer --noconfirm'
    );
    await coderes('systemctl enable gdm.service');
    ok();
    xfce = true;
  } else if(sel == 'GNOME') {
    print('=============== GNOME =============== \n');
    await coderes('pacman -S xorg --noconfirm');
    await coderes('pacman -S gnome gdm gnome-themes-standard '
      'network-manager-applet --noconfirm'
    );
    await coderes('pacman -S firefox grub-customizer --noconfirm');
    await coderes('systemctl enable gdm.service');
    ok();
    xfce = false;
  } else if(sel == 'Plasma') {
    print('=============== KDE =============== \n');
    await coderes('pacman -S xorg --noconfirm');
    await coderes('pacman -S plasma plasma-wayland-session '
      'kde-applications gnome-themes-standard --noconfirm'
    );
    await coderes('pacman -S network-manager-applet '
      'firefox grub-customizer --noconfirm'
    );
    await coderes('systemctl enable sddm.service');
    ok();
    xfce = false;
  } else if(sel == 'XORG') {
    print('=============== XORG ONLY =============== \n');
    await coderes('pacman -S xorg --noconfirm');
    ok();
    xfce = false;
  } else if(sel == 'CUTEFISH') {
    print('=============== CUTEFISH =============== \n');
    await coderes('pacman -S xorg --noconfirm');
    await coderes('pacman -S cutefish --noconfirm');
    ok();
    xfce = false;
  } else {
    xfce = false;
  }
  xfce = isXfce;
}
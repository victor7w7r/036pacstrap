import 'dart:io';

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/messages.dart';

Future<void> aur() async {

  clear();
  lang(29, PrintQuery.normal);

  await coderes(
    'pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com'
  );
  await coderes('pacman-key --lsign-key FBA220DFC880C036');
  await coderes("pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' "
    "'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm"
  );
  await call("sed -i \"/\\[multilib\\]/,/Include/\"'s/^//' /etc/pacman.conf");
  File('/etc/pacman.conf').writeAsStringSync(
    '[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n',
    mode: FileMode.append
  );

  await coderes('pacman -Syyu yay linux-lqx '
    'linux-lqx-headers pamac-aur rate-mirrors --noconfirm'
  );

  await call('rate-mirrors --allow-root --protocol '
    'https arch | sudo tee /etc/pacman.d/mirrorlist'
  );

  await coderes('pacman -S --needed fakeroot packer --noconfirm');

  await coderes('grub-mkconfig -o /boot/grub/grub.cfg');

  okMessage();
}

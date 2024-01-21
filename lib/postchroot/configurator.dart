import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> configurator() async {
  clear();
  lang(30, PrintQuery.normal);
  await coderes('passwd');
  okMessage();
  clear();
  cyan(lang(31));

  if (chooser(lang(12), ['Intel', 'AMD']).run() == 'Intel') {
    clear();
    print('=============== INTEL MICROCODE  =============== \n');
    await coderes('pacman -S intel-ucode --noconfirm');
    okMessage();
  } else {
    clear();
    print('=============== AMD MICROCODE  =============== \n');
    await coderes('pacman -S amd-ucode --noconfirm');
    okMessage();
  }

  clear();

  lang(32, PrintQuery.normal);

  await coderes('grub-install --target=x86_64-efi '
      '--efi-directory=/boot/efi --bootloader-id=arch');
  await coderes('grub-mkconfig -o /boot/grub/grub.cfg');
  await call('umount /boot/efi');

  okMessage();

  clear();

  lang(33, PrintQuery.normal);

  await coderes('systemctl enable NetworkManager');
  await coderes('systemctl enable sshd');
  await call(r"sed -i 's/^#PermitRootLogin\s.*$/PermitRootLogin yes/' "
      '/etc/ssh/sshd_config &> /dev/null');

  okMessage();
}

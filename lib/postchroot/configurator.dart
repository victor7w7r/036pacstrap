import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Configurator {
  const Configurator(
    this._colorize,
    this._io,
    this._lang,
    this._messages,
  );

  final Colorize _colorize;
  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;

  Future<void> call() async {
    _io.clear();
    _lang.write(30, PrintQuery.normal);
    await _io.coderes('passwd');
    _messages.okMessage();
    _io.clear();
    _colorize.cyan(_lang.write(31));
    print(_lang.write(12));
    if (_lang.chooser(['Intel', 'AMD']) == 'Intel') {
      _io.clear();
      print('=============== INTEL MICROCODE  =============== \n');
      await _io.coderes('pacman -S intel-ucode --noconfirm');
      _messages.okMessage();
    } else {
      _io.clear();
      print('=============== AMD MICROCODE  =============== \n');
      await _io.coderes('pacman -S amd-ucode --noconfirm');
      _messages.okMessage();
    }

    _io.clear();

    _lang.write(32, PrintQuery.normal);

    await _io.coderes('grub-install --target=x86_64-efi '
        '--efi-directory=/boot/efi --bootloader-id=arch');
    await _io.coderes('grub-mkconfig -o /boot/grub/grub.cfg');
    await _io.call('umount /boot/efi');

    _messages.okMessage();

    _io.clear();

    _lang.write(33, PrintQuery.normal);

    await _io.coderes('systemctl enable NetworkManager');
    await _io.coderes('systemctl enable sshd');
    await _io.call(r"sed -i 's/^#PermitRootLogin\s.*$/PermitRootLogin yes/' "
        '/etc/ssh/sshd_config &> /dev/null');

    _messages.okMessage();
  }
}

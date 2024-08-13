import 'dart:io' show File, FileMode;

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/messages.dart';

@injectable
class Aur {
  const Aur(this._lang, this._io, this._messages);

  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;

  Future<void> call() async {
    _io.clear();
    _lang.write(41, PrintQuery.normal);

    await _io.coderes(
      'pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com',
    );
    await _io.coderes('pacman-key --lsign-key 3056513887B78AEB');
    await _io.coderes(
        "pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' "
        "'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm");
    await _io
        .call("sed -i \"/\\[multilib\\]/,/Include/\"'s/^//' /etc/pacman.conf");
    File('/etc/pacman.conf').writeAsStringSync(
      '[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n',
      mode: FileMode.append,
    );

    await _io.coderes('pacman -Syyu yay pamac-aur rate-mirrors --noconfirm');
    await _io.call('rate-mirrors --allow-root --protocol '
        'https arch | sudo tee /etc/pacman.d/mirrorlist');
    await _io.coderes('pacman -S --needed fakeroot packer --noconfirm');
    await _io.coderes('grub-mkconfig -o /boot/grub/grub.cfg');
    _messages.okMessage();
  }
}

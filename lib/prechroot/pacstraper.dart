// ignore_for_file: lines_longer_than_80_chars

import 'dart:async' show unawaited;

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/toggler.dart';

@injectable
class Pacstraper {
  const Pacstraper(this._io, this._lang, this._messages, this._toggler);

  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;
  final Toggler _toggler;

  Future<void> call() async {
    _io.clear();
    _lang.write(28, PrintQuery.normal);

    await _io.coderes(
        'pacstrap /mnt base linux linux-firmware linux-headers nano sudo '
        'neovim git wget grub efibootmgr os-prober rsync networkmanager neofetch '
        'base-devel openssh arch-install-scripts screen p7zip fish dosfstools');
    await _io.call('genfstab -U /mnt >> /mnt/etc/fstab');

    _messages.okMessage();

    unawaited(_toggler());
  }
}

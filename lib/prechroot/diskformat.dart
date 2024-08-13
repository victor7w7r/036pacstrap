import 'dart:async' show unawaited;

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/pacstraper.dart';

@injectable
class Diskformat {
  const Diskformat(
    this._io,
    this._lang,
    this._messages,
    this._pacstraper,
    this._var,
  );

  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;
  final Pacstraper _pacstraper;
  final Variables _var;

  String _swapPart(final List<String> partCodes) {
    var count = 1;

    var result = '';

    for (final code in partCodes) {
      if (code == '8200') {
        result = '${_var.disk}$count';
        break;
      }
      count++;
    }

    return result;
  }

  Future<void> call(
    final List<String> partCodes,
  ) async {
    _io.clear();

    print(_lang.write(27));

    if (_var.diskenvdev == 'HDD') {
      _var.swappart = _swapPart(partCodes);
      if (_var.swappart != '') {
        await _io.coderes('mkswap ${_var.swappart}');
        await _io.coderes('swapon ${_var.swappart}');
      }
    }

    await _io.coderes('mkfs.btrfs -f ${_var.rootpart}');

    final mountOp =
        // ignore: lines_longer_than_80_chars
        'rw,noatime,${_var.diskenvdev == 'HDD' ? 'autodefrag' : 'discard=async'},compress-force=zstd,space_cache=v2,commit=120';

    await _io.call('mount -o $mountOp ${_var.rootpart} /mnt');
    await _io.call('mkdir /mnt/boot; mkdir /mnt/boot/efi');
    await _io.call('mount ${_var.efipart} /mnt/boot/efi');

    _messages.okMessage();

    unawaited(_pacstraper());
  }
}

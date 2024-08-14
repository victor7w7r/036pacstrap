import 'dart:async' show unawaited;

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/diskformat.dart';

@injectable
class Partitioning {
  const Partitioning(
    this._attach,
    this._colorize,
    this._diskformat,
    this._io,
    this._lang,
    this._variables,
  );

  final Attach _attach;
  final Colorize _colorize;
  final Diskformat _diskformat;
  final InputOutput _io;
  final Lang _lang;
  final Variables _variables;

  List<String> _linuxParts(final List<String> partCodes) {
    var count = 1;

    final result = <String>[];

    for (final code in partCodes) {
      if (code == '8300') {
        result.add(
          _variables.disk.contains('nvme')
              ? '${_variables.disk}p$count'
              : '${_variables.disk}$count',
        );
      }
      count++;
    }

    return result;
  }

  Future<void> _menuPartitioning(
    final String sel,
    final List<String> partCodes,
  ) async {
    final efiSize = await _io.sys('export LANG=C; '
        'sudo parted -s ${_variables.disk} unit MiB p '
        "| awk '{ if (\$3 == \"End\") { flag=1 } if (flag) { print \$3 } }' "
        "| sed -ne '2p'; "
        'export LANG= ');

    if (sel == _lang.write(21)) {
      _io.clear();
      await _io.coderes('cgdisk ${_variables.disk}');
      unawaited(call());
    } else if (sel == _lang.write(22)) {
      _io.clear();
      await _io.coderes('parted ${_variables.disk}');
      unawaited(call());
    } else if (sel == _lang.write(23)) {
      await _io.call('parted -s ${_variables.disk} unit MiB mkpart primary '
          'btrfs $efiSize 100%');
      _variables.rootpart = _variables.disk.contains('nvme')
          ? '${_variables.disk}p2'
          : '${_variables.disk}2';
      unawaited(_diskformat(partCodes));
    } else if (sel == _lang.write(24)) {
      _io.clear();
      _attach.successExit();
    } else {
      _variables.rootpart = sel;
      unawaited(_diskformat(partCodes));
    }
  }

  Future<void> call() async {
    _io.clear();

    final partCodes = await _io.syssplit('export LANG=C; '
        'sudo gdisk -l ${_variables.disk} '
        "| awk '{ if (\$6 == \"Size\") { flag=1 } if (flag) { print \$6 } }' "
        "| sed '1d'; "
        'export LANG= ');

    _colorize
      ..cyan(_lang.write(partCodes.contains('8300') ? 25 : 20))
      ..red(_lang.write(26));
    print(_lang.write(12));

    await _menuPartitioning(
      _attach.chooser([
        if (partCodes.contains('8300')) ..._linuxParts(partCodes),
        _lang.write(21),
        _lang.write(22),
        _lang.write(23),
        _lang.write(24),
      ]),
      partCodes,
    );
  }
}

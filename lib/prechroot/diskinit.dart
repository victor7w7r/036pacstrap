import 'dart:io' show exit;

import 'package:fpdart/fpdart.dart' show Task;
import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class DiskInit {
  const DiskInit(
    this._attach,
    this._colorize,
    this._io,
    this._lang,
    this._messages,
    this._variables,
  );

  final Attach _attach;
  final Colorize _colorize;
  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;
  final Variables _variables;

  Future<String> _efiCreate(final String device) async {
    await _io.call('parted --script $device mkpart primary fat32 1MiB 200MiB');
    await _io.call('parted --script $device set 1 esp on');
    final efipartquery = await _io.syswline(
      'fdisk -l ${_variables.disk} | sed -ne /EFI/p | cut -d " " -f1',
    );
    await _io.coderes('mkfs.fat -F32 $efipartquery');

    return efipartquery;
  }

  Future<void> _initGpt(final String device) =>
      _io.call('parted --script $device mklabel gpt');

  Future<void> call(final String device) async {
    _io.clear();

    if (await _io.sys('blkid -o value -s PTTYPE $device') != 'gpt') {
      _colorize
        ..cyan(_lang.write(14))
        ..red(_lang.write(15));
      if (_attach.stdYesNo()) {
        await _initGpt(device);
        _io.clear();
      } else {
        _io.clear();
        exit(0);
      }
    }

    final efi = await _io.sys("fdisk -l $device | sed -ne '/EFI/p'");
    final numberPart =
        await _io.sys("fdisk -l $device | grep -c '^$device[0-9]'");

    if (numberPart != '0') await _io.call('sudo umount -f $device*');

    if (efi == '' && numberPart == '0') {
      _colorize.cyan(_lang.write(16));
      _variables.efipart = await _efiCreate(device);
      _messages.okMessage();
    } else if (efi == '' && numberPart != '0') {
      _colorize
        ..cyan(_lang.write(18))
        ..red(_lang.write(15));
      if (_attach.stdYesNo()) {
        _io.clear();
        _colorize.cyan(_lang.write(16));
        _variables.efipart = await _efiCreate(device);
        _messages.okMessage();
      } else {
        _io.clear();
        exit(0);
      }
    } else if (efi != '' && numberPart != '0') {
      if (await _io.sys("echo $efi | sed -ne '/[[:alpha:]]1/p'") == '') {
        _colorize
          ..cyan(_lang.write(19))
          ..red(_lang.write(15));
        if (_attach.stdYesNo()) {
          _io.clear();
          _colorize.cyan(_lang.write(16));
          await _initGpt(device);
          _variables.efipart = await _efiCreate(device);
          _messages.okMessage();
        } else {
          _io.clear();
          exit(0);
        }
      } else {
        _variables.efipart = efi;
      }
    } else {
      _variables.efipart = efi;
    }

    RegExp('sd[A-Za-z]').hasMatch(device)
        ? _variables.diskenvdev =
            (await Task(() => _io.sys('echo $device | cut -d "/" -f3'))
                        .flatMap(
                          (final block) => Task(
                            () => _io
                                .sys('cat /sys/block/$block/queue/rotational'),
                          ),
                        )
                        .run() ==
                    '0')
                ? 'SSD'
                : 'HDD'
        : _variables.diskenvdev = 'SSD';

    _variables.disk = device;
  }
}

import 'dart:io' show exit;

import 'package:fpdart/fpdart.dart' show Task;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> _initGpt(final String device) =>
    call('parted --script $device mklabel gpt');

Future<String> _efiCreate(final String device) async {
  await call('parted --script $device mkpart primary fat32 1MiB 200MiB');
  await call('parted --script $device set 1 esp on');
  final efipartquery =
      await syswline('fdisk -l $disk | sed -ne /EFI/p | cut -d " " -f1');
  await coderes('mkfs.fat -F32 $efipartquery');
  return efipartquery;
}

Future<void> diskinit(final String device) async {
  clear();

  if (await sys('blkid -o value -s PTTYPE $device') != 'gpt') {
    cyan(lang(14));
    red(lang(15));
    if (stdYesNo()) {
      await _initGpt(device);
      clear();
    } else {
      clear();
      exit(0);
    }
  }

  final efi = await sys("fdisk -l $device | sed -ne '/EFI/p'");
  final numberPart = await sys("fdisk -l $device | grep -c '^$device[0-9]'");

  if (numberPart != '0') await call('sudo umount -f $device*');

  if (efi == '' && numberPart == '0') {
    cyan(lang(16));
    efipart = await _efiCreate(device);
    okMessage();
  } else if (efi == '' && numberPart != '0') {
    cyan(lang(18));
    red(lang(15));
    if (stdYesNo()) {
      clear();
      cyan(lang(16));
      efipart = await _efiCreate(device);
      okMessage();
    } else {
      clear();
      exit(0);
    }
  } else if (efi != '' && numberPart != '0') {
    if (await sys("echo $efi | sed -ne '/[[:alpha:]]1/p'") == '') {
      cyan(lang(19));
      red(lang(15));
      if (stdYesNo()) {
        clear();
        cyan(lang(16));
        await _initGpt(device);
        efipart = await _efiCreate(device);
        okMessage();
      } else {
        clear();
        exit(0);
      }
    } else {
      efipart = efi;
    }
  } else {
    efipart = efi;
  }

  RegExp('sd[A-Za-z]').hasMatch(device)
      ? diskenvdev = (await Task(() => sys('echo $device | cut -d "/" -f3'))
                  .flatMap(
                    (final block) => Task(
                      () => sys('cat /sys/block/$block/queue/rotational'),
                    ),
                  )
                  .run() ==
              '0')
          ? 'SSD'
          : 'HDD'
      : diskenvdev = 'SSD';

  disk = device;
}

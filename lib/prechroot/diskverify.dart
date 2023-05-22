import 'dart:io' show exit;

import 'package:fpdart/fpdart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> diskverify(
  final String device
) async {

  clear();

  if(await sys('blkid -o value -s PTTYPE $device') == 'dos') {
    lang(12, PrintQuery.error);
    exit(1);
  }

  final efi = await sys(
    "fdisk -l $device | sed -ne '/EFI/p'"
  );

  if(efi == '') {
    lang(15, PrintQuery.error);
    exit(1);
  }

  if(await sys("echo $efi | sed -ne '/[[:alpha:]]1/p'") == '') {
    lang(16, PrintQuery.error);
    exit(1);
  }

  if(RegExp(r'sd[A-Za-z]').hasMatch(device)) {
    final rotational = await Task(() =>
      sys('echo $device | cut -d "/" -f3')
    )
      .flatMap((block) => Task(() =>
        sys('cat /sys/block/$block/queue/rotational'))
      )
      .run();

    if(diskenvdev == 'SSD' && rotational == '1') {
      lang(13, PrintQuery.error);
      exit(1);
    }

    if(diskenvdev == 'HDD' && rotational == '0') {
      lang(14, PrintQuery.error);
      exit(1);
    }
  } else {
    if(diskenvdev == 'HDD') {
      lang(14, PrintQuery.error);
      exit(1);
    }
  }

  disk = device;
}
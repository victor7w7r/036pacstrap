import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:pacstrap/index.dart';

Future<void> diskverify(String device) async {

  final diskenv = locator.get<App>().diskenv;

  clear();

  if(await sysout('blkid -o value -s PTTYPE $device') == 'dos') {
    lang(12, PrintQuery.error);
    exit(1);
  }

  final efi = await sysout("fdisk -l $device | sed -ne '/EFI/p'");
  final efiorder = await sysout("echo $efi | sed -ne '/[[:alpha:]]1/p'");

  if(efi == '') {
    lang(15, PrintQuery.error);
    exit(1);
  }

  if(efiorder == '') {
    lang(16, PrintQuery.error);
    exit(1);
  }

  if(RegExp(r'sd[A-Za-z]').hasMatch(device)) {
    final rotational = await Task(() => sysout('echo $device | cut -d "/" -f3'))
      .flatMap((block) => Task(() => sysout('cat /sys/block/$block/queue/rotational')))
      .run();

    if(diskenv == 'SSD' && rotational == '1') {
      lang(13, PrintQuery.error);
      exit(1);
    }

    if(diskenv == 'HDD' && rotational == '0') {
      lang(14, PrintQuery.error);
      exit(1);
    }
  } else {
    if(diskenv == 'HDD') {
      lang(14, PrintQuery.error);
      exit(1);
    }
  }

  locator.get<App>().disk = device;
}
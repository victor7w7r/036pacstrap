import 'dart:io';

import 'package:pacstrap/pacstrap.dart';

Future<void> diskformat() async {

  clear();

  if(diskenvdev == 'HDD') {
    await dialog(
      '036 Creative Studios',
      '${lang(44)} \n'
      '$efipart (EFI) \n'
      '$rootpart (ROOT) \n'
      '$swappart (SWAP)', '10', '50'
    );
    clear();
    contQuestion();

    if(stdYesNo()) {
      clear();
      lang(18, PrintQuery.normal);
      await coderes('mkfs.ext4 -F $rootpart');
      await coderes('mkswap $swappart');
      await coderes('swapon $swappart');
      ok();
    } else {
      clear();
      exit(0);
    }
  } else {
    await dialog(
      '036 Creative Studios',
      '${lang(44)} \n'
      '$efipart (EFI) \n'
      '$rootpart (ROOT)', '10', '50'
    );
    clear();

    contQuestion();

    if(stdYesNo()) {
      clear();
      lang(19, PrintQuery.normal);
      await coderes('mkfs.f2fs -f $rootpart');
      ok();
    } else {
      clear();
      exit(0);
    }
  }

  clear();
  lang(20, PrintQuery.normal);

  await coderes('mkfs.fat -F32 $efipart');
  await call(
    'mount $rootpart /mnt; mkdir /mnt/boot; mkdir /mnt/boot/efi'
  );
  await call('mount $efipart /mnt/boot/efi');

  ok();
}
import 'dart:async' show unawaited;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/prechroot/prechroot.dart';
import 'package:pacstrap/pacstrap.dart';

String _swapPart(final List<String> partCodes) {
  var count = 1;

  var result = '';

  for (final code in partCodes) {
    if (code == '8200') {
      result = '$disk$count';
      break;
    }
    count++;
  }

  return result;
}

Future<void> diskformat(final String partCodes) async {
  clear();

  print(lang(26));

  if (diskenvdev == 'HDD') {
    swappart = _swapPart(partCodes);
    if (swappart != '') {
      await coderes('mkswap $swappart');
      await coderes('swapon $swappart');
    }
  }

  await coderes(
    '${diskenvdev == 'HDD' ? 'mkfs.ext4 -F' : 'mkfs.f2fs -f'} $rootpart',
  );

  await call('mount $rootpart /mnt; mkdir /mnt/boot; mkdir /mnt/boot/efi');
  await call('mount $efipart /mnt/boot/efi');

  okMessage();

  unawaited(pacstraper());
}

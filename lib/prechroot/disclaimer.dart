import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> disclaimer() async {
  clear();
  await dialog('036 Creative Studios', lang(38), '10', '55');

  await dialog(
      '036 Creative Studios',
      '${lang(39)} \n'
          'GPT ->\n'
          '1.	/dev/sdX1	EFI			200MB		fat32		esp\n'
          '2.	/dev/sdX2	archlinux	>20GB	'
          '${diskenvdev == 'HDD' ? 'ext4' : 'ext4/f2fs'}   primary\n'
          // ignore: lines_longer_than_80_chars
          '${diskenvdev == 'HDD' ? '3.	/dev/sdx3	linux-swap	2GB-4GB		swap		primary' : ''} \n'
          '${lang(40)} \n'
          'mklabel gpt \n'
          'mkpart EFI fat32 1MiB 200MiB \n'
          'set 1 esp on \n'
          'mkpart ROOT ext4 200MiB 19.0GiB \n'
          'mkpart SWAP linux-swap 19.0GiB 100%',
      '15',
      '100');
}

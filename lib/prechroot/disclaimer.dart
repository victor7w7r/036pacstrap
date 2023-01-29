import 'package:pacstrap/index.dart';

Future<void> disclaimer() async {

  clear();
  await dialog('036 Creative Studios', lang(38), '10', '55');

  if(locator.get<App>().diskenv == "HDD") {
    await dialog('036 Creative Studios', """${lang(39)}
      GPT ->
      1.	/dev/sdX1	EFI			200MB		fat32		esp
      2.	/dev/sdX2	archlinux	>20GB		ext4		primary
      3.	/dev/sdx3	linux-swap	2GB-4GB		swap		primary
      ${lang(40)}
      mklabel gpt
      mkpart EFI fat32 1MiB 200MiB
      set 1 esp on
      mkpart ROOT ext4 200MiB 19.0GiB
      mkpart SWAP linux-swap 19.0GiB 100%""", '15', '100');
  } else {
    await dialog('036 Creative Studios', """${lang(39)}
      GPT ->
      1.	/dev/sdX1	EFI			200MB		fat32		esp
      2.	/dev/sdX2	archlinux	>20GB		f2fs/ext4		primary
      ${lang(40)}
      mklabel gpt
      mkpart EFI fat32 1MiB 200MiB
      set 1 esp on
      mkpart ROOT f2fs 200MiB 100%""", '15', '100');
  }
}
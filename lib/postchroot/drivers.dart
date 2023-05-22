import 'package:dcli/dcli.dart' show cyan;

import 'package:pacstrap/pacstrap.dart';

Future<void> drivers() async {

  clear();

  print(cyan(lang(51)));

  final sel = stdChoose([
    'Intel', 'ATI', 'AMD',
    'NVIDIA', 'VMware'
  ]);

  clear();

  if(sel == 'Intel') {
    print('=============== INTEL =============== \n');
    await coderes('pacman -S xf86-video-intel '
      'intel-media-driver intel-media-sdk --noconfirm'
    );
    ok();
  } else if (sel == 'ATI') {
    print('=============== ATI =============== \n');
    await coderes(
      'pacman -S xf86-video-ati --noconfirm'
    );
    ok();
  } else if(sel == 'AMD') {
    print('=============== AMD =============== \n');
    await coderes(
      'pacman -S xf86-video-amdgpu --noconfirm'
    );
    ok();
  } else if(sel == 'NVIDIA') {
    print('=============== NVIDIA =============== \n');
    await coderes(
      'pacman -S nvidia nvidia-utils --noconfirm'
    );
    ok();
  } else if(sel == 'VMware') {
    print('=============== VMWARE =============== \n');
    await coderes(
      'pacman -S gtkmm3 open-vm-tools xf86-input-vmmouse '
      'xf86-video-vmware --noconfirm'
    );
    await coderes('systemctl enable vmtoolsd');
    ok();
  }

}
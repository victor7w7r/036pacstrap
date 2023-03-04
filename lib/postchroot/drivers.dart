import 'dart:io' show stdin;

import 'package:console/console.dart' show Chooser;
import 'package:dcli/dcli.dart' show cyan;

import 'package:pacstrap/index.dart';

void _ok() {
  print('');
  print('=============== OK =============== \n');
  print(lang(45));
  stdin.readLineSync();
}

Future<void> drivers() async {

  clear();

  print(cyan(lang(51)));
  final sel = Chooser<String>(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware'], message: lang(33)).chooseSync();

  clear();

  if(sel == 'Intel') {
    print('=============== INTEL =============== \n');
    await codeproc('pacman -S xf86-video-intel intel-media-driver intel-media-sdk --noconfirm');
    _ok();
  } else if (sel == 'ATI') {
    print('=============== ATI =============== \n');
    await codeproc('pacman -S xf86-video-ati --noconfirm');
    _ok();
  } else if(sel == 'AMD') {
    print('=============== AMD =============== \n');
    await codeproc('pacman -S xf86-video-amdgpu --noconfirm');
    _ok();
  } else if(sel == 'NVIDIA') {
    print('=============== NVIDIA =============== \n');
    await codeproc('pacman -S nvidia nvidia-utils --noconfirm');
    _ok();
  } else if(sel == 'VMware') {
    print('=============== VMWARE =============== \n');
    await codeproc('pacman -S gtkmm3 open-vm-tools xf86-input-vmmouse xf86-video-vmware --noconfirm');
    await codeproc('systemctl enable vmtoolsd');
    _ok();
  }

}
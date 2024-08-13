import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Drivers {
  const Drivers(
    this._attach,
    this._colorize,
    this._io,
    this._lang,
    this._messages,
  );

  final Attach _attach;
  final Colorize _colorize;
  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;

  Future<void> call() async {
    _io.clear();

    _colorize.cyan(_lang.write(40));

    final sel = _attach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']);

    _io.clear();

    if (sel == 'Intel') {
      print('=============== INTEL =============== \n');
      await _io.coderes('pacman -S xf86-video-intel '
          'intel-media-driver intel-media-sdk --noconfirm');
      _messages.okMessage();
    } else if (sel == 'ATI') {
      print('=============== ATI =============== \n');
      await _io.coderes('pacman -S xf86-video-ati --noconfirm');
      _messages.okMessage();
    } else if (sel == 'AMD') {
      print('=============== AMD =============== \n');
      await _io.coderes('pacman -S xf86-video-amdgpu --noconfirm');
      _messages.okMessage();
    } else if (sel == 'NVIDIA') {
      print('=============== NVIDIA =============== \n');
      await _io.coderes('pacman -S nvidia nvidia-utils --noconfirm');
      _messages.okMessage();
    } else if (sel == 'VMware') {
      print('=============== VMWARE =============== \n');
      await _io.coderes('pacman -S gtkmm3 open-vm-tools xf86-input-vmmouse '
          'xf86-video-vmware --noconfirm');
      await _io.coderes('systemctl enable vmtoolsd');
      _messages.okMessage();
    }
  }
}

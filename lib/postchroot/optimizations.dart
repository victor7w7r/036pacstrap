import 'dart:io' show File;

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Optimizations {
  const Optimizations(this._io, this._lang, this._messages);

  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;

  Future<void> call() async {
    _io.clear();
    _lang.write(44, PrintQuery.normal);

    await _io.coderes(
      """sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=0 nowatchdog"/' /etc/default/grub &> /dev/null""",
    );
    await _io.coderes('grub-mkconfig -o /boot/grub/grub.cfg');
    await _io.call('touch /etc/modprobe.d/blacklists.conf');

    File('/etc/modprobe.d/blacklists.conf').writeAsStringSync(
      'blacklist iTCO_wdt\n'
      'blacklist joydev\n'
      'blacklist mousedev\nblacklist mac_hid',
    );

    _messages.okMessage();
  }
}

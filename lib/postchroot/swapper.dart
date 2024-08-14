import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart' show InputOutput;

import 'package:pacstrap/pacstrap.dart';

@injectable
class Swapper {
  const Swapper(this._attach, this._io, this._messages, this._variables);

  final Attach _attach;
  final InputOutput _io;
  final Messages _messages;
  final Variables _variables;

  Future<void> call() async {
    _io.clear();
    _messages.header('SWAPPING');

    if (_variables.diskenvdev == 'HDD') {
      _attach.appendFile('/etc/sysctl.d/99-sysctl.conf', 'vm.swappiness=60');
    } else {
      await _io.coderes(
        "sudo -u ${_variables.sudouser} bash -c 'cd; git clone https://aur.archlinux.org/zramswap.git'",
      );
      await _io.coderes(
        // ignore: lines_longer_than_80_chars
        "sudo -u ${_variables.sudouser} bash -c 'cd; cd zramswap; makepkg -si --noconfirm'",
      );
      await _io
          .call("sudo -u ${_variables.sudouser} bash -c 'cd; rm -rf zramswap'");
      await _io.call('systemctl enable zramswap.service');
    }
    _messages.okMessage();
  }
}

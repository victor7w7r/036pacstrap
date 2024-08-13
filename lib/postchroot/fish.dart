import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Fish {
  const Fish(this._io, this._messages, this._variables);

  final InputOutput _io;
  final Messages _messages;
  final Variables _variables;

  Future<void> call() async {
    _io.clear();

    _messages.header('FISH');

    await _io.coderes(
      'sudo -u ${_variables.sudouser} bash -c "eval \'\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\'; brew install Code-Hex/tap/neo-cowsay"',
    );

    await _io.coderes('pacman -S lolcat thefuck --noconfirm');
    _io.clear();
    await _io
        .call("sudo -u ${_variables.sudouser} bash -c 'chsh -s /bin/fish'");
    await _io.call('chsh -s /bin/fish');
    await _io.coderes(
      'git clone https://github.com/victor7w7r/dotfiles /root/dotfiles',
    );
    await _io.call('mkdir /root/.config');
    await _io.call('mkdir /home/${_variables.sudouser}/.config');
    await _io.call('cp -r /root/dotfiles/fish /root/.config/fish');
    await _io.call(
      'cp -r /root/dotfiles/fish /home/${_variables.sudouser}/.config/fish',
    );
    await _io.call(
      'chown -R ${_variables.sudouser}:${_variables.sudouser} /home/${_variables.sudouser}/.config',
    );
    await _io.call(
      'chown -R ${_variables.sudouser}:${_variables.sudouser} /home/${_variables.sudouser}/.config/fish',
    );
    _messages.okMessage();
  }
}

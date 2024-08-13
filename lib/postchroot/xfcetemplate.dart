import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Xfcetemplate {
  const Xfcetemplate(
    this._attach,
    this._colorize,
    this._io,
    this._lang,
    this._messages,
    this._variables,
  );

  final Attach _attach;
  final Colorize _colorize;
  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;
  final Variables _variables;

  Future<void> call() async {
    _io.clear();

    _colorize.cyan(_lang.write(43));

    if (_attach.stdYesNo()) {
      _io.clear();
      await _io
          .coderes('pacman -S catppuccin-gtk-theme-mocha papirus-icon-theme '
              'ttf-ubuntu-font-family --noconfirm');
      await _io.call('cp -r /root/dotfiles/local/share /root/.local/share');
      await _io.call('cp -r /root/dotfiles/xfce4 /root/.config/xfce4');
      await _io.call(
        'cp -r /root/dotfiles/xfce4 /home/${_variables.sudouser}/.config/xfce4',
      );
      await _io.call(
        'cp -r /root/.local/share /home/${_variables.sudouser}/.local/share',
      );
      await _io.call('cp -r /root/dotfiles/xfce4 /root/.config/xfce4');
      await _io.call('cp -r /root/dotfiles/gtk-3.0 /root/.config/gtk-3.0');
      await _io.call(
        'cp -r /root/dotfiles/gtk-3.0 /home/${_variables.sudouser}/.config/gtk-3.0',
      );
      await _io.call(
        'chown -R ${_variables.sudouser}:${_variables.sudouser} /home/${_variables.sudouser}/.config/xfce4',
      );
      await _io.call(
        'chown -R ${_variables.sudouser}:${_variables.sudouser} /home/${_variables.sudouser}/.config/gtk-3.0',
      );
      await _io.call('rm -rf /root/dotfiles');
      _messages.okMessage();
    }
  }
}

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Graphical {
  const Graphical(
    this._attach,
    this._colorize,
    this._io,
    this._lang,
    this._messages,
    this._tui,
    this._variables,
  );

  final Attach _attach;
  final Colorize _colorize;
  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;
  final Tui _tui;
  final Variables _variables;

  Future<void> call() async {
    _io.clear();
    await _tui.dialog('036 Creative Studios', _lang.write(39), '8', '80');
    _io.clear();

    _colorize.cyan(_lang.write(39));

    final sel = _attach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']);

    _io.clear();
    if (sel == 'XFCE') {
      print('=============== XFCE =============== \n');
      await _io.coderes('pacman -S xorg --noconfirm');
      await _io.coderes(
          'pacman -S xfce4 xfce4-goodies gtk-engines gtk-engine-murrine '
          'xdg-user-dirs gvfs network-manager-applet '
          'volumeicon firefox gdm grub-customizer --noconfirm');
      await _io.coderes('systemctl enable gdm.service');
      _messages.okMessage();
      _variables.xfce = true;
    } else if (sel == 'GNOME') {
      print('=============== GNOME =============== \n');
      await _io.coderes('pacman -S xorg --noconfirm');
      await _io.coderes('pacman -S gnome gdm gnome-themes-standard '
          'network-manager-applet --noconfirm');
      await _io.coderes('pacman -S firefox grub-customizer --noconfirm');
      await _io.coderes('systemctl enable gdm.service');
      _messages.okMessage();
      _variables.xfce = false;
    } else if (sel == 'Plasma') {
      print('=============== KDE =============== \n');
      await _io.coderes('pacman -S xorg --noconfirm');
      await _io.coderes('pacman -S plasma plasma-wayland-session '
          'kde-applications gnome-themes-standard --noconfirm');
      await _io.coderes('pacman -S network-manager-applet '
          'firefox grub-customizer --noconfirm');
      await _io.coderes('systemctl enable sddm.service');
      _messages.okMessage();
      _variables.xfce = false;
    } else if (sel == 'XORG') {
      print('=============== XORG ONLY =============== \n');
      await _io.coderes('pacman -S xorg --noconfirm');
      _messages.okMessage();
      _variables.xfce = false;
    } else {
      _variables.xfce = false;
    }
  }
}

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/attach.dart';

@injectable
class HostnameLocale {
  const HostnameLocale(
    this._attach,
    this._colorize,
    this._io,
    this._lang,
    this._tui,
  );

  final Attach _attach;
  final Colorize _colorize;
  final InputOutput _io;
  final Lang _lang;
  final Tui _tui;

  Future<void> hostnamer() async {
    _io.clear();

    await _attach.readInputSync(_lang.write(34)).then(
          (final ans) => _attach
            ..writeFile('/etc/hostname', ans)
            ..appendFile('/etc/hosts', 'echo 127.0.1.1 $ans'),
        );
  }

  Future<void> localer() async {
    _io.clear();

    await _tui.dialog('036 Creative Studios', _lang.write(35), '9', '50');
    await _io.call('ln -sf /usr/share/zoneinfo/America/Guayaquil '
        '/etc/localtime');
    await _io.call('hwclock --systohc');

    _io.clear();

    _colorize.cyan(_lang.write(36));
    _lang.write(12);
    final sel = _lang.chooser(['es_ES', 'en_US']);

    _io.clear();
    await _io.call(
      "sed -i 's/^#$sel.UTF-8 UTF-8/$sel.UTF-8 UTF-8/' /etc/locale.gen &> /dev/null",
    );
    await _io.coderes('locale-gen');

    _attach.writeFile(
      '/etc/locale.conf',
      'LANG="$sel.UTF-8"\nLC_TIME="$sel.UTF-8"\nLANGUAGE="$sel:$sel:es"\n',
    );
  }
}

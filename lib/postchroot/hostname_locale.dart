import 'dart:async' show unawaited;
import 'dart:io' show File, FileMode;

import 'package:console/console.dart' show readInput;
import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

@injectable
class HostnameLocale {
  const HostnameLocale(this._colorize, this._io, this._lang, this._tui);

  final Colorize _colorize;
  final InputOutput _io;
  final Lang _lang;
  final Tui _tui;

  Future<void> hostnamer() async {
    _io.clear();

    await readInput(_lang.write(34)).then((final ans) {
      File('/etc/hostname').writeAsStringSync(ans);
      File('/etc/hosts')
          .writeAsStringSync('echo 127.0.1.1 $ans', mode: FileMode.append);
    });
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
    unawaited(
      File('/etc/locale.conf').writeAsString(
        'LANG="$sel.UTF-8"\nLC_TIME="$sel.UTF-8"\nLANGUAGE="$sel:$sel:es"\n',
      ),
    );
  }
}

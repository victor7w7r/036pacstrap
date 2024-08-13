import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Blackarch {
  const Blackarch(
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
    _colorize.cyan(_lang.write(42));
    if (_attach.stdYesNo()) {
      await _io.coderes('cd; curl -O https://blackarch.org/strap.sh');
      await _io.call('chmod +x /root/strap.sh');
      await _io.coderes('/root/strap.sh');
      _messages.okMessage();
    }
  }
}

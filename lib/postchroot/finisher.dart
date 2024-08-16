import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Finisher {
  const Finisher(this._attach, this._io, this._lang, this._tui);

  final Attach _attach;
  final InputOutput _io;
  final Lang _lang;
  final Tui _tui;

  Future<void> call() async {
    _io.clear();
    await _tui.dialog('036 Creative Studios', _lang.write(45), '8', '80');
    _io.clear();
    _lang.write(46, PrintQuery.normal);
    _attach.successExit();
  }
}

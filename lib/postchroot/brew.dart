import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Brew {
  const Brew(
    this._io,
    this._lang,
    this._messages,
    this._variables,
  );

  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;
  final Variables _variables;

  Future<void> call() async {
    _io.clear();
    _lang.write(47, PrintQuery.normal);

    await _io.coderes(
      'sudo -u ${_variables.sudouser} bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"',
    );
    _messages.okMessage();
  }
}

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Newuser {
  const Newuser(
    this._attach,
    this._io,
    this._lang,
    this._messages,
    this._variables,
  );

  final Attach _attach;
  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;
  final Variables _variables;

  Future<void> call() async {
    _io.clear();
    _lang
      ..write(37, PrintQuery.normal)
      ..write(38, PrintQuery.normal);

    final sudouserreq = _attach.readSync();

    await _io.coderes('useradd --create-home $sudouserreq');
    await _io.coderes('passwd $sudouserreq');
    await _io.call('usermod -aG wheel,storage,power $sudouserreq');
    await _io.call(
      r"sed -i 's/^#.*%wheel ALL=(ALL) ALL$/%wheel ALL=(ALL) ALL/' /etc/sudoers &> /dev/null",
    );
    await _io
        .call('echo "$sudouserreq ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers');

    _messages.okMessage();

    _variables.sudouser = sudouserreq;
  }
}

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class Toggler {
  const Toggler(
    this._attach,
    this._io,
    this._lang,
    this._messages,
    this._var,
  );

  final Attach _attach;
  final InputOutput _io;
  final Lang _lang;
  final Messages _messages;
  final Variables _var;

  Future<void> call() async {
    _io.clear();
    _messages.header('CHROOT');

    await _io.call('cp ${_attach.currentPath}/pacstrap /mnt/pacstrap');
    await _io.call('chmod +x /mnt/pacstrap');
    await _io.coderes(
      'arch-chroot /mnt ./pacstrap chroot ${_var.diskenvdev} ${_lang.isEnglish ? 1 : 0}',
    );

    _lang.write(29, PrintQuery.normal);
    await _io.call('rm -f /mnt/pacstrap &> /dev/null');
  }
}

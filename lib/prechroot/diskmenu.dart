import 'dart:io' show exit;

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

@injectable
class DiskMenu {
  const DiskMenu(this._attach, this._colorize, this._io, this._lang);

  final Attach _attach;
  final Colorize _colorize;
  final InputOutput _io;
  final Lang _lang;

  Future<List<String>> _allDevsDisk() => _io
      .syssplit('lsblk -o NAME -e 2,3,4,5,6,7,9,10,11 -d ' r"| sed -ne '2,$p'");

  Future<String> call() async {
    _io.clear();

    final parts = await _allDevsDisk();

    parts.removeWhere((final part) => part.isEmpty);

    if (parts.isEmpty) {
      _lang.write(11, PrintQuery.normal);
      exit(1);
    }

    _colorize.cyan(_lang.write(13));

    print(_lang.write(12));

    return _attach.chooser(parts.map((final part) => '/dev/$part').toList());
  }
}

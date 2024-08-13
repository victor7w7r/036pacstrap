// coverage:ignore-file

import 'dart:io';

import 'package:cli_menu/cli_menu.dart' show Menu;
import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

@injectable
class Attach {
  const Attach(this._lang);

  final Lang _lang;

  bool get isLinux => Platform.isLinux;

  String chooser(
    final List<String> opts,
  ) =>
      Menu(opts).choose().value;

  String readSync() => stdin.readLineSync() ?? '';

  String stdChoose(final List<String> options) {
    _lang.write(12);

    return chooser(options);
  }

  bool stdYesNo() => _lang.isYesNo(_lang.write(12));

  void successExit() => exit(0);
}

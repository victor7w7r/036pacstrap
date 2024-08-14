// coverage:ignore-file

import 'dart:io';

import 'package:cli_menu/cli_menu.dart' show Menu;
import 'package:console/console.dart' show readInput;
import 'package:injectable/injectable.dart' show injectable;
import 'package:system_info2/system_info2.dart' show SysInfo;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart'
    show InternetConnectionChecker;

@injectable
class Attach {
  const Attach(this._lang);

  final Lang _lang;

  String get currentPath => Directory.current.path;

  bool get isLinux => Platform.isLinux;

  bool get isx64 =>
      SysInfo.kernelArchitecture.name == 'x86_64' ||
      SysInfo.kernelArchitecture.name == 'X86_64';

  void appendFile(
    final String file,
    final String content,
  ) =>
      File(file).writeAsStringSync(content, mode: FileMode.append);

  String chooser(
    final List<String> opts,
  ) =>
      Menu(opts).choose().value;

  bool dirExists(final String path) => Directory(path).existsSync();

  void errorExit() => exit(1);

  Future<bool> internetCheck() => InternetConnectionChecker().hasConnection;

  Future<String> readInputSync(final String message) => readInput(message);

  String readSync() => stdin.readLineSync() ?? '';

  String stdChoose(final List<String> options) {
    _lang.write(12);

    return chooser(options);
  }

  bool stdYesNo() => _lang.isYesNo(_lang.write(12));

  void successExit() => exit(0);

  void writeFile(
    final String file,
    final String content,
  ) =>
      File(file).writeAsStringSync(content);
}

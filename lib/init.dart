import 'dart:io' show Directory, Platform;

import 'package:injectable/injectable.dart' show injectable;
import 'package:system_info2/system_info2.dart' show SysInfo;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart'
    show InternetConnectionChecker;

@injectable
class Init {
  const Init(
    this._initLang,
    this._io,
    this._lang,
    this._tui,
    this._var,
  );

  final InitLang _initLang;
  final InputOutput _io;
  final Lang _lang;
  final Tui _tui;
  final Variables _var;

  Future<void> call(final List<String> args) async {
    _initLang();

    if (args.isEmpty) {
      _io.clear();
      _initLang();
      _lang.assignLang();
      _io.clear();
      cover();

      final spinAction = _tui.spin();

      if (!Platform.isLinux) _lang.error(0);

      await _io
          .checkUid()
          .then((final val) => onlyIf(!val, () => _lang.error(1)));

      onlyIf(
        !Directory('/sys/firmware/efi').existsSync(),
        () => _lang.error(2),
      );

      onlyIf(
        !(SysInfo.kernelArchitecture.name == 'x86_64' ||
            SysInfo.kernelArchitecture.name == 'X86_64'),
        () => _lang.error(3),
      );

      await _io
          .success('pacman')
          .then((final val) => onlyIf(!val, () => _lang.error(4)));

      await InternetConnectionChecker().hasConnection.then(
            (final iin) => onlyIf(
              !iin,
              () => _lang.error(5),
            ),
          );

      _lang.write(6, PrintQuery.normal);
      await _io.call('pacman -Sy &> /dev/null');

      await _io.success('fsck.btrfs').then((final val) async {
        if (!val) {
          _lang.write(7, PrintQuery.normal);
          await _io.call('pacman -S btrfs-progs --noconfirm &> /dev/null');
        }
      });

      await _io.success('whiptail').then((final val) async {
        if (!val) {
          _lang.write(8, PrintQuery.normal);
          await _io.call('pacman -S whiptail --noconfirm &> /dev/null');
        }
      });

      await _io.success('pacstrap').then((final val) async {
        if (!val) {
          _lang.write(9, PrintQuery.normal);
          await _io
              .call('pacman -S arch-install-scripts --noconfirm &> /dev/null');
        }
      });

      await _io.call(
        'pacman -S ncurses wget awk gdisk fdisk --noconfirm &> /dev/null',
      );

      _lang.write(10, PrintQuery.normal);

      spinAction.cancel();
    } else {
      _var.diskenvdev = args[1];
      _lang.isEnglish = args[2] == '1';
    }
  }
}

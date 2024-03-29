import 'dart:io' show Directory, Platform;

import 'package:internet_connection_checker/internet_connection_checker.dart'
    show InternetConnectionChecker;
import 'package:system_info2/system_info2.dart' show SysInfo;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> init(final List<String> args) async {
  initLang();

  if (args.isEmpty) {
    clear();
    setLang();
    clear();
    cover();

    final spinAction = spin();

    if (!Platform.isLinux) error(0);

    await checkUid().then((final val) => onlyIf(!val, () => error(1)));

    onlyIf(!Directory('/sys/firmware/efi').existsSync(), () => error(2));

    onlyIf(
      !(SysInfo.kernelArchitecture.name == 'x86_64' ||
          SysInfo.kernelArchitecture.name == 'X86_64'),
      () => error(3),
    );

    await success('pacman').then((final val) => onlyIf(!val, () => error(4)));

    await InternetConnectionChecker().hasConnection.then(
          (final iin) => onlyIf(
            !iin,
            () => error(5),
          ),
        );

    lang(6, PrintQuery.normal);
    await call('pacman -Sy &> /dev/null');

    await success('fsck.f2fs').then((final val) async {
      if (!val) {
        lang(7, PrintQuery.normal);
        await call('pacman -S f2fs-tools --noconfirm &> /dev/null');
      }
    });

    await success('whiptail').then((final val) async {
      if (!val) {
        lang(8, PrintQuery.normal);
        await call('pacman -S whiptail --noconfirm &> /dev/null');
      }
    });

    await success('pacstrap').then((final val) async {
      if (!val) {
        lang(9, PrintQuery.normal);
        await call('pacman -S arch-install-scripts --noconfirm &> /dev/null');
      }
    });

    await call(
      'pacman -S ncurses wget awk gdisk fdisk --noconfirm &> /dev/null',
    );

    lang(10, PrintQuery.normal);

    spinAction.cancel();
  } else {
    diskenvdev = args[1];
    english = args[2] == '1';
  }
}

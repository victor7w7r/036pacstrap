import 'dart:async' show unawaited;
import 'dart:io' show File, FileMode;

import 'package:console/console.dart' show readInput;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

Future<void> hostnamer() async {
  clear();

  await readInput(lang(34)).then((final ans) {
    File('/etc/hostname').writeAsStringSync(ans);
    File('/etc/hosts')
        .writeAsStringSync('echo 127.0.1.1 $ans', mode: FileMode.append);
  });
}

Future<void> localer() async {
  clear();

  await dialog('036 Creative Studios', lang(35), '9', '50');
  await call('ln -sf /usr/share/zoneinfo/America/Guayaquil '
      '/etc/localtime');
  await call('hwclock --systohc');

  clear();

  cyan(lang(36));

  final sel = chooser(lang(12), ['es_ES', 'en_US']).run();

  clear();
  await call(
    "sed -i 's/^#$sel.UTF-8 UTF-8/$sel.UTF-8 UTF-8/' /etc/locale.gen &> /dev/null",
  );
  await coderes('locale-gen');
  unawaited(
    File('/etc/locale.conf').writeAsString(
      'LANG="$sel.UTF-8"\nLC_TIME="$sel.UTF-8"\nLANGUAGE="$sel:$sel:es"\n',
    ),
  );
}

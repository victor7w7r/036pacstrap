import 'dart:async' show unawaited;
import 'dart:io' show File, FileMode;

import 'package:dcli/dcli.dart' show cyan;
import 'package:console/console.dart' show readInput;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

Future<void> hostnamer() async {

  clear();

  await readInput(lang(46)).then((final ans){
    File('/etc/hostname').writeAsStringSync(ans);
    File('/etc/hosts').writeAsStringSync(
      'echo 127.0.1.1 $ans',
      mode: FileMode.append
    );
  });
}

Future<void> localer() async {

  clear();

  await dialog('036 Creative Studios', lang(47), '9', '50');
  await call('ln -sf /usr/share/zoneinfo/America/Guayaquil '
    '/etc/localtime'
  );
  await call('hwclock --systohc');

  clear();

  print(cyan(lang(48)));

  final sel = chooser(lang(33), ['es_ES', 'en_US']).run();

  clear();
  await call(
    "sed -i 's/^#$sel.UTF-8 UTF-8/$sel.UTF-8 UTF-8/' /etc/locale.gen &> /dev/null"
  );
  await coderes('locale-gen');
  unawaited(File('/etc/hostname').writeAsString(
    'LANG="$sel.UTF-8"\nLC_TIME="$sel.UTF-8"\nLANGUAGE="$sel:$sel:es"\n'
  ));

}

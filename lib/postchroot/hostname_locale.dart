import 'dart:io' show File, FileMode;

import 'package:dcli/dcli.dart' show cyan;
import 'package:console/console.dart' show Chooser, readInput;

import 'package:pacstrap/index.dart';

Future<void> hostnamer() async {

  clear();

  await readInput(lang(46)).then((ans){
    File('/etc/hostname').writeAsStringSync(
      ans,
      mode: FileMode.write
    );
    File('/etc/hosts').writeAsStringSync(
      'echo 127.0.1.1 $ans',
      mode: FileMode.append
    );
  });
}

Future<void> localer() async {

  clear();

  await dialog('036 Creative Studios', lang(47), '9', '50');
  await syscall("ln -sf /usr/share/zoneinfo/America/Guayaquil /etc/localtime");
  await syscall("hwclock --systohc");

  clear();

  print(cyan(lang(48)));

  final sel = Chooser<String>(["es_ES", "en_US"], message: lang(33)).chooseSync();

  if(sel == "es_ES") {
    clear();
    await syscall("sed -i 's/^#es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen &> /dev/null");
    await codeproc("locale-gen");
    File f3 = File('/etc/hostname');
    f3.writeAsString('LANG="es_ES.UTF-8"\nLC_TIME="es_ES.UTF-8"\nLANGUAGE="es_EC:es_ES:es"\n', mode: FileMode.write);
  } else  {
    clear();
    await syscall("sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen &> /dev/null");
    await codeproc("locale-gen");
    File f3 = File('/etc/hostname');
    f3.writeAsString('LANG="en_US.UTF-8"\nLC_TIME="en_US.UTF-8"\nLANGUAGE="es_US:en"\n', mode: FileMode.write);
  }

}
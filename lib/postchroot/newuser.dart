import 'dart:io' show stdin, stdout;

import 'package:pacstrap/pacstrap.dart';

Future<void> newuser() async {

  clear();
  lang(28, PrintQuery.normal);

  stdout.write(lang(49));

  final sudouserreq = stdin.readLineSync()!;

  await coderes('useradd --create-home $sudouserreq');
  await coderes('passwd $sudouserreq');
  await call('usermod -aG wheel,storage,power $sudouserreq');
  await call("sed -i 's/^#.*%wheel ALL=(ALL) ALL\$/%wheel ALL=(ALL) ALL/' /etc/sudoers &> /dev/null");
  await call('echo "$sudouserreq ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers');

  ok();

  sudouser = sudouserreq;

}


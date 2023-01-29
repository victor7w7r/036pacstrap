import 'dart:io' show stdin, stdout;

import 'package:pacstrap/index.dart';

Future<void> newuser() async {

  clear();
  lang(28, PrintQuery.normal);

  stdout.write(lang(49));

  final sudouser = stdin.readLineSync()!;

  await codeproc("useradd --create-home $sudouser");
  await codeproc("passwd $sudouser");
  await syscall("usermod -aG wheel,storage,power $sudouser");
  await syscall("sed -i 's/^#.*%wheel ALL=(ALL) ALL\$/%wheel ALL=(ALL) ALL/' /etc/sudoers &> /dev/null");
  await syscall("echo \"$sudouser ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers");

  print("");
  print("=============== OK =============== \n");
  print(lang(45));
  stdin.readLineSync();

  locator.get<App>().sudouser = sudouser;

}


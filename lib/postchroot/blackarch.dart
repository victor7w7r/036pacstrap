import 'dart:io' show stdin;

import 'package:dcli/dcli.dart' show cyan;
import 'package:console/console.dart' show Chooser;

import 'package:pacstrap/index.dart';

Future<void> blackarch() async {

  clear();

  print(cyan(lang(57)));

  final sel = Chooser<String>(locator.get<App>().english ? ["Yes", "No"] : ["Si", "No"], message: lang(33)).chooseSync();

  if(sel == "Yes" || sel == "Si") {
    await codeproc("cd; curl -O https://blackarch.org/strap.sh");
    await syscall("chmod +x /root/strap.sh");
    await codeproc("/root/strap.sh");

    print("");
    print("=============== OK =============== \n");
    print(lang(45));
    stdin.readLineSync();
  }
}
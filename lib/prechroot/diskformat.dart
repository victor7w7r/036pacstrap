import 'dart:io';

import 'package:dcli/dcli.dart' show cyan;
import 'package:console/console.dart' show Chooser;

import 'package:pacstrap/index.dart';

void _ok() {
  print("");
  print("=============== OK =============== \n");
  print(lang(45));
  stdin.readLineSync();
}

Future<void> diskformat() async {

  final app = locator.get<App>();

  clear();

  if(app.diskenv=="HDD") {
    await dialog('036 Creative Studios', '${lang(44)} \n${app.efipart} (EFI) \n${app.rootpart} (ROOT) \n${app.swappart} (SWAP)', '10', '50');
    clear();
    print(cyan(app.english ? "Continue?\n " : "Continuar?\n "));

    final sel = Chooser<String>(locator.get<App>().english ? ["Yes", "No"] : ["Si", "No"], message: lang(33)).chooseSync();

    if(sel == "Yes" || sel == "Si") {
      clear();
      lang(18, PrintQuery.normal);
      await codeproc("mkfs.ext4 -F ${app.rootpart}");
      await codeproc("mkswap ${app.swappart}");
      await codeproc("swapon ${app.swappart}");
      _ok();
    } else {
      clear();
      exit(0);
    }
  } else {
    await dialog('036 Creative Studios', '${lang(44)} \n${app.efipart} (EFI) \n${app.rootpart} (ROOT)', '10', '50');
    clear();
    print(cyan(app.english ? "Continue?\n " : "Continuar?\n "));
    final sel = Chooser<String>(locator.get<App>().english ? ["Yes", "No"] : ["Si", "No"], message: lang(33)).chooseSync();

    if(sel == "Yes" || sel == "Si") {
      clear();
      lang(19, PrintQuery.normal);
      await codeproc("mkfs.f2fs -f ${app.rootpart}");
      _ok();
    } else {
      clear();
      exit(0);
    }
  }

  clear();
  lang(20, PrintQuery.normal);

  await codeproc("mkfs.fat -F32 ${app.efipart}");
  await syscall("mount ${app.rootpart} /mnt; mkdir /mnt/boot; mkdir /mnt/boot/efi");
  await syscall("mount ${app.efipart} /mnt/boot/efi");

  _ok();
}
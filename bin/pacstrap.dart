import 'package:pacstrap/index.dart';

import 'package:pacstrap/prechroot/index.dart';
import 'package:pacstrap/postchroot/index.dart';

Future<void> corelive() async {
  clear();
  diskenv();
  await disclaimer();
  await diskverify(await diskmenu());
  await rootpartmenu();
  await swapmenu();
  await diskformat();
  await pacstraper();
  await toggler();
}

Future<void> corechroot() async {
  await configurator();
  await hostnamer();
  await localer();
  await newuser();
  await graphical();
  await drivers();
  await aur();
  await blackarch();
  await docker();
  await zsh();
  await swapper();
  if(locator.get<App>().xfce) await xfcetemplate();
  await optimizations();
  await software();
  await finisher();
}

Future<void> main(List<String> args) async {

  setup();

  await locator.get<App>().init(args);

  if(args.isEmpty) {
    await corelive();
    return;
  } else {
    if(args[0] == 'chroot') {
      corechroot();
      return;
    }
  }
}
import 'dart:async' show unawaited;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/prechroot.dart';
import 'package:pacstrap/postchroot/postchroot.dart';

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
  if(xfce) await xfcetemplate();
  await optimizations();
  await software();
  await finisher();
}

void main(
  final List<String> args
) async {

  await init(args);

  if(args.isEmpty) {
    unawaited(corelive());
  } else {
    if(args[0] == 'chroot') unawaited(corechroot());
  }
}

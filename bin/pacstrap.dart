import 'dart:async' show unawaited;

import 'package:zerothreesix_dart/zerothreesix_dart.dart' show clear;

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/postchroot.dart';
import 'package:pacstrap/prechroot/prechroot.dart';

Future<void> corelive() async {
  clear();
  await diskinit(await diskmenu());
  await partitioning();
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
  await fish();
  await swapper();
  if (xfce) await xfcetemplate();
  await optimizations();
  await finisher();
}

void main(final List<String> args) async {
  await init(args);

  if (args.isEmpty) {
    unawaited(corelive());
  } else {
    if (args[0] == 'chroot') unawaited(corechroot());
  }
}

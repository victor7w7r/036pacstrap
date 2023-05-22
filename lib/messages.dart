import 'dart:io' show stdin;

import 'package:dcli/dcli.dart' show cyan;

import 'package:pacstrap/pacstrap.dart';

void contQuestion() => print(cyan(
  english ? 'Continue?\n ' : 'Continuar?\n ')
);

void header(
  final String title
) => print('=============== $title =============== \n');

void ok() {
  print('');
  print('=============== OK =============== \n');
  print(lang(45));
  stdin.readLineSync();
}

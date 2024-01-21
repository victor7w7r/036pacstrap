import 'dart:io' show stdin;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

void contQuestion() => cyan(english ? 'Continue?\n ' : 'Continuar?\n ');

void header(final String title) =>
    print('=============== $title =============== \n');

void okMessage() {
  print('');
  print('=============== OK =============== \n');
  print(lang(17));
  stdin.readLineSync();
}

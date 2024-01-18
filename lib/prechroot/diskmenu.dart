import 'dart:io' show exit;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

Future<List<String>> _allDevsDisk() =>
    syssplit('lsblk -o NAME -e 2,3,4,5,6,7,9,10,11 -d ' r"| sed -ne '2,$p'");

Future<String> diskmenu() async {
  clear();

  final parts = await _allDevsDisk();

  parts.removeWhere((final part) => part.isEmpty);

  if (parts.isEmpty) {
    lang(11, PrintQuery.normal);
    exit(1);
  }

  cyan(lang(41));

  return chooser(lang(33), parts.map((final part) => '/dev/$part').toList())
      .run();
}

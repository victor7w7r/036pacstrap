import 'dart:io' show exit;

import 'package:pacstrap/pacstrap.dart';

Future<void> finisher() async {
  clear();
  await dialog('036 Creative Studios', lang(55), '8', '80');
  clear();
  lang(34, PrintQuery.normal);
  exit(0);
}
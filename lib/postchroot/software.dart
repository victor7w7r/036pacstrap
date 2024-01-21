import 'dart:io' show File;

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

Future<void> software() async {
  clear();

  File('/etc/X11/Xwrapper.config').writeAsStringSync('allowed_users=anybody');
}

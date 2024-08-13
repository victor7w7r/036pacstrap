import 'dart:async' show unawaited;

import 'package:get_it/get_it.dart' show GetIt;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

void main(final List<String> args) async {
  setupDartUtils();
  configInjection();

  await GetIt.I<Init>()(args);

  final app = GetIt.I<App>();

  args.isEmpty
      ? unawaited(app.corelive())
      : unawaited(onlyIf(args[0] == 'chroot', app.corechroot));
}

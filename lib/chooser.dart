import 'package:console/console.dart' show Chooser;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:pacstrap/pacstrap.dart';

IO<String> chooser(
  final String message,
  final List<String> options
) => IO(Chooser<String>(
  options,
  message: message
).chooseSync);

String stdChoose(
  final List<String> options
) => chooser(lang(33), options).run();

bool yesNo(
  final String message
) => chooser(
  message,
  english ? ['Yes', 'No'] : ['Si', 'No'],
)
  .map((sel) => sel == 'Yes' || sel == 'Si')
  .run();

bool stdYesNo() => yesNo(lang(33));

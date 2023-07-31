import 'package:zerothreesix_dart/zerothreesix_dart.dart' show chooser, lang, yesNo;

String stdChoose(
  final List<String> options
) => chooser(lang(33), options).run();

bool stdYesNo() => yesNo(lang(33));

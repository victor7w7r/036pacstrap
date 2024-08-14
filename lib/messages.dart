import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/attach.dart';

@injectable
class Messages {
  const Messages(this._attach, this._colorize, this._lang);

  final Attach _attach;
  final Colorize _colorize;
  final Lang _lang;

  void contQuestion() =>
      _colorize.cyan(_lang.isEnglish ? 'Continue?\n ' : 'Continuar?\n ');

  void header(final String title) =>
      print('=============== $title =============== \n');

  void okMessage() {
    print('');
    print('=============== OK =============== \n');
    print(_lang.write(17));
    _attach.readSync();
  }
}

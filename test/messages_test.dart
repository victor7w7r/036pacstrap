// ignore_for_file: lines_longer_than_80_chars, no_adjacent_strings_in_list

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

final class MockAttach extends Mock implements Attach {}

final class MockColorize extends Mock implements Colorize {}

final class MockLang extends Mock implements Lang {}

void main() {
  group('Messages', () {
    late MockAttach attach;
    late MockColorize colorize;
    late MockLang lang;

    late Messages messages;

    setUp(() {
      attach = MockAttach();
      colorize = MockColorize();
      lang = MockLang();

      messages = Messages(attach, colorize, lang)..header('test');
    });

    test('contQuestion is english', () {
      when(() => lang.isEnglish).thenReturn(true);
      when(() => colorize.cyan('Continue?\n ')).thenReturn(null);

      messages.contQuestion();

      verify(() => colorize.cyan('Continue?\n '));
    });

    test('contQuestion is not english', () {
      when(() => lang.isEnglish).thenReturn(false);
      when(() => colorize.cyan('Continuar?\n ')).thenReturn(null);

      messages.contQuestion();

      verify(() => colorize.cyan('Continuar?\n '));
    });

    test('okMessage', () {
      when(() => lang.write(17)).thenReturn('test');
      when(() => attach.readSync()).thenReturn('');

      messages.okMessage();

      verify(() => lang.write(17));
      verify(() => attach.readSync());
    });
  });
}

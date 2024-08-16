import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/postchroot.dart';

final class MockAttach extends Mock implements Attach {}

final class MockColorize extends Mock implements Colorize {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockMessages extends Mock implements Messages {}

void main() {
  group('Configurator', () {
    late MockColorize mockColorize;
    late MockInputOutput mockIo;
    late MockLang mockLang;
    late MockMessages mockMessages;

    late Configurator configurator;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockColorize = MockColorize();
      mockIo = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();

      configurator = Configurator(
        mockColorize,
        mockIo,
        mockLang,
        mockMessages,
      );
    });

    test('call configure with intel microcode', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(30, PrintQuery.normal)).thenReturn('');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);
      when(() => mockLang.write(31)).thenReturn('');
      when(() => mockLang.write(12)).thenReturn('');
      when(() => mockLang.chooser(['Intel', 'AMD'])).thenReturn('Intel');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockLang.write(32, PrintQuery.normal)).thenReturn('');
      when(() => mockLang.write(33, PrintQuery.normal)).thenReturn('');

      await configurator();

      verify(mockIo.clear).called(5);
      verify(() => mockLang.write(30, PrintQuery.normal)).called(1);
      verify(() => mockIo.coderes(any())).called(6);
      verify(() => mockIo.call(any())).called(2);
      verify(mockMessages.okMessage).called(4);
      verify(() => mockLang.write(31)).called(1);
      verify(() => mockLang.write(12)).called(1);
      verify(() => mockLang.chooser(['Intel', 'AMD'])).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(() => mockLang.write(32, PrintQuery.normal)).called(1);
      verify(() => mockLang.write(33, PrintQuery.normal)).called(1);
    });

    test('call configure with amd microcode', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(30, PrintQuery.normal)).thenReturn('');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);
      when(() => mockLang.write(31)).thenReturn('');
      when(() => mockLang.write(12)).thenReturn('');
      when(() => mockLang.chooser(['Intel', 'AMD'])).thenReturn('AMD');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockLang.write(32, PrintQuery.normal)).thenReturn('');
      when(() => mockLang.write(33, PrintQuery.normal)).thenReturn('');

      await configurator();

      verify(mockIo.clear).called(5);
      verify(() => mockLang.write(30, PrintQuery.normal)).called(1);
      verify(() => mockIo.coderes(any())).called(6);
      verify(() => mockIo.call(any())).called(2);
      verify(mockMessages.okMessage).called(4);
      verify(() => mockLang.write(31)).called(1);
      verify(() => mockLang.write(12)).called(1);
      verify(() => mockLang.chooser(['Intel', 'AMD'])).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(() => mockLang.write(32, PrintQuery.normal)).called(1);
      verify(() => mockLang.write(33, PrintQuery.normal)).called(1);
    });
  });
}

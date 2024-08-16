import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/prechroot.dart';

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockMessages extends Mock implements Messages {}

final class MockToggler extends Mock implements Toggler {}

void main() {
  group('Toggler', () {
    late MockInputOutput mockInputOutput;
    late MockLang mockLang;
    late MockMessages mockMessages;
    late MockToggler mockToggler;

    late Pacstraper pacstraper;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockInputOutput = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();
      mockToggler = MockToggler();

      pacstraper = Pacstraper(
        mockInputOutput,
        mockLang,
        mockMessages,
        mockToggler,
      );
    });

    test('call pacstraper', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockLang.write(28, PrintQuery.normal)).thenReturn('');
      when(() => mockInputOutput.call(any())).thenAnswer((final _) async => 1);
      when(() => mockInputOutput.coderes(any()))
          .thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);
      when(() => mockToggler()).thenAnswer((final _) async {});

      await pacstraper();

      verify(() => mockInputOutput.clear()).called(1);
      verify(() => mockLang.write(28, PrintQuery.normal)).called(1);
      verify(() => mockInputOutput.call(any())).called(1);
      verify(() => mockInputOutput.coderes(any())).called(1);
      verify(mockMessages.okMessage).called(1);
    });
  });
}

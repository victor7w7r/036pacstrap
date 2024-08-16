import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/toggler.dart';

final class MockAttach extends Mock implements Attach {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockMessages extends Mock implements Messages {}

final class MockVariables extends Mock implements Variables {}

void main() {
  group('Toggler', () {
    late MockAttach mockAttach;
    late MockInputOutput mockInputOutput;
    late MockLang mockLang;
    late MockMessages mockMessages;
    late MockVariables mockVariables;

    late Toggler toggler;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockAttach = MockAttach();
      mockInputOutput = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();
      mockVariables = MockVariables();

      toggler = Toggler(
        mockAttach,
        mockInputOutput,
        mockLang,
        mockMessages,
        mockVariables,
      );
    });

    test('call toggler', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockAttach.currentPath).thenReturn('');
      when(() => mockLang.isEnglish).thenReturn(true);
      when(() => mockVariables.diskenvdev).thenReturn('');
      when(() => mockMessages.header('CHROOT')).thenReturn(null);
      when(() => mockInputOutput.call(any())).thenAnswer((final _) async => 1);
      when(() => mockInputOutput.coderes(any()))
          .thenAnswer((final _) async => 1);
      when(() => mockLang.write(29, PrintQuery.normal)).thenReturn('');

      await toggler();

      verify(() => mockInputOutput.clear()).called(1);
      verify(() => mockMessages.header('CHROOT')).called(1);
      verify(() => mockInputOutput.coderes(any())).called(1);
      verify(() => mockLang.write(29, PrintQuery.normal)).called(1);
      verify(() => mockInputOutput.call(any())).called(3);
    });
  });
}

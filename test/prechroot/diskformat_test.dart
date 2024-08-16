import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/prechroot.dart';

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockMessages extends Mock implements Messages {}

final class MockPacstraper extends Mock implements Pacstraper {}

final class MockVariables extends Mock implements Variables {}

void main() {
  group('Diskformat', () {
    late MockInputOutput mockInputOutput;
    late MockLang mockLang;
    late MockMessages mockMessages;
    late MockPacstraper mockPacstraper;
    late MockVariables mockVariables;

    late Diskformat diskformat;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockInputOutput = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();
      mockPacstraper = MockPacstraper();
      mockVariables = MockVariables();

      diskformat = Diskformat(
        mockInputOutput,
        mockLang,
        mockMessages,
        mockPacstraper,
        mockVariables,
      );
    });

    test('call diskformat', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockLang.write(27)).thenReturn('');
      when(() => mockVariables.diskenvdev).thenReturn('HDD');
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockVariables.efipart).thenReturn('/dev/sda1');
      when(() => mockVariables.swappart).thenReturn('/dev/sda2');
      when(() => mockVariables.rootpart).thenReturn('/dev/sda3');
      when(() => mockInputOutput.coderes(any()))
          .thenAnswer((final _) async => 1);
      when(() => mockInputOutput.call(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);
      when(() => mockPacstraper()).thenAnswer((final _) async {});

      await diskformat(['8300', '8200']);

      verify(() => mockInputOutput.clear()).called(1);
      verify(() => mockLang.write(27)).called(1);
      verify(() => mockVariables.diskenvdev).called(2);
      verify(() => mockVariables.efipart).called(1);
      verify(() => mockVariables.swappart).called(3);
      verify(() => mockVariables.rootpart).called(2);
      verify(() => mockInputOutput.coderes(any())).called(3);
      verify(() => mockInputOutput.call(any())).called(3);
      verify(mockMessages.okMessage).called(1);
      verify(() => mockPacstraper()).called(1);
    });
  });
}

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
  group('Blackarch', () {
    late MockAttach mockAttach;
    late MockColorize mockColorize;
    late MockInputOutput mockInputOutput;
    late MockLang mockLang;
    late MockMessages mockMessages;

    late Blackarch blackarch;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockAttach = MockAttach();
      mockColorize = MockColorize();
      mockInputOutput = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();

      blackarch = Blackarch(
        mockAttach,
        mockColorize,
        mockInputOutput,
        mockLang,
        mockMessages,
      );
    });

    test('call aur', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockLang.write(42)).thenReturn('');
      when(() => mockAttach.stdYesNo()).thenReturn(true);
      when(() => mockInputOutput.coderes(any()))
          .thenAnswer((final _) async => 0);
      when(() => mockInputOutput.call(any())).thenAnswer((final _) async => 0);
      when(mockMessages.okMessage).thenReturn(null);

      await blackarch();

      verify(() => mockInputOutput.clear()).called(1);
      verify(() => mockLang.write(42)).called(1);
      verify(() => mockAttach.stdYesNo()).called(1);
      verify(() => mockInputOutput.call(any())).called(1);
      verify(() => mockInputOutput.coderes(any())).called(2);
      verify(mockMessages.okMessage).called(1);
    });
  });
}

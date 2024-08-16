import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/aur.dart';

final class MockAttach extends Mock implements Attach {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockMessages extends Mock implements Messages {}

void main() {
  group('Aur', () {
    late MockAttach mockAttach;
    late MockInputOutput mockInputOutput;
    late MockLang mockLang;
    late MockMessages mockMessages;

    late Aur aur;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockAttach = MockAttach();
      mockInputOutput = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();

      aur = Aur(
        mockAttach,
        mockLang,
        mockInputOutput,
        mockMessages,
      );
    });

    test('call aur', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockLang.write(41, PrintQuery.normal)).thenReturn('');
      when(() => mockInputOutput.coderes(any()))
          .thenAnswer((final _) async => 0);
      when(() => mockAttach.appendFile(any(), any()))
          .thenAnswer((final _) async => 0);
      when(() => mockInputOutput.call(any())).thenAnswer((final _) async => 0);
      when(mockMessages.okMessage).thenReturn(null);

      await aur();

      verify(() => mockInputOutput.clear()).called(1);
      verify(() => mockLang.write(41, PrintQuery.normal)).called(1);
      verify(() => mockInputOutput.coderes(any())).called(6);
      verify(() => mockAttach.appendFile(any(), any())).called(1);
      verify(mockMessages.okMessage).called(1);
    });
  });
}

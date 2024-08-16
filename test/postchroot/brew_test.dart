import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/postchroot.dart';

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockMessages extends Mock implements Messages {}

final class MockVariables extends Mock implements Variables {}

void main() {
  group('Brew', () {
    late MockInputOutput mockIo;
    late MockLang mockLang;
    late MockMessages mockMessages;
    late MockVariables mockVariables;

    late Brew brew;

    setUp(() {
      mockIo = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();
      mockVariables = MockVariables();

      brew = Brew(mockIo, mockLang, mockMessages, mockVariables);
    });

    test('call brew', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(47, PrintQuery.normal)).thenReturn('');
      when(() => mockVariables.sudouser).thenReturn('testuser');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);

      await brew.call();

      verify(mockIo.clear).called(1);
      verify(() => mockVariables.sudouser).called(1);
      verify(() => mockLang.write(47, PrintQuery.normal)).called(1);
      verify(() => mockIo.coderes(any())).called(1);
      verify(mockMessages.okMessage).called(1);
    });
  });
}

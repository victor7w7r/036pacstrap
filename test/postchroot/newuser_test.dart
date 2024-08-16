import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/postchroot.dart';

final class MockAttach extends Mock implements Attach {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockMessages extends Mock implements Messages {}

final class MockVariables extends Mock implements Variables {}

void main() {
  group('Newuser', () {
    late MockAttach mockAttach;
    late MockInputOutput mockIo;
    late MockLang mockLang;
    late MockMessages mockMessages;
    late MockVariables mockVariables;

    late Newuser newuser;

    setUp(() {
      mockAttach = MockAttach();
      mockIo = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();
      mockVariables = MockVariables();

      newuser = Newuser(
        mockAttach,
        mockIo,
        mockLang,
        mockMessages,
        mockVariables,
      );
    });

    test('call newuser', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(37, PrintQuery.normal)).thenReturn('');
      when(() => mockLang.write(38, PrintQuery.inline)).thenReturn('');
      when(mockAttach.readSync).thenReturn('');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockMessages.okMessage()).thenReturn(null);
      when(() => mockVariables.sudouser).thenReturn('');

      await newuser.call();

      verify(mockIo.clear).called(1);
      verify(() => mockLang.write(37, PrintQuery.normal)).called(1);
      verify(() => mockLang.write(38, PrintQuery.inline)).called(1);
      verify(mockAttach.readSync).called(1);
      verify(() => mockIo.coderes(any())).called(2);
      verify(() => mockIo.call(any())).called(3);
      verify(mockMessages.okMessage).called(1);
    });
  });
}

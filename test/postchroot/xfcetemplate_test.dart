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

final class MockVariables extends Mock implements Variables {}

void main() {
  group('Xfcetemplate', () {
    late MockAttach mockAttach;
    late MockColorize mockColorize;
    late MockInputOutput mockIo;
    late MockLang mockLang;
    late MockMessages mockMessages;
    late MockVariables mockVariables;

    late Xfcetemplate xfcetemplate;

    setUp(() {
      mockAttach = MockAttach();
      mockColorize = MockColorize();
      mockIo = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();
      mockVariables = MockVariables();

      xfcetemplate = Xfcetemplate(
        mockAttach,
        mockColorize,
        mockIo,
        mockLang,
        mockMessages,
        mockVariables,
      );
    });

    test('call xfcetemplate', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(43)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(mockAttach.stdYesNo).thenReturn(true);
      when(() => mockVariables.sudouser).thenReturn('');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(mockMessages.okMessage).thenReturn(null);

      await xfcetemplate.call();

      verify(mockIo.clear).called(2);
      verify(() => mockLang.write(43)).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(mockAttach.stdYesNo).called(1);
      verify(() => mockIo.coderes(any())).called(1);
      verify(() => mockIo.call(any())).called(10);
      verify(mockMessages.okMessage).called(1);
    });
  });
}

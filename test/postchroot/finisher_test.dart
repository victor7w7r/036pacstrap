import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/postchroot.dart';

final class MockAttach extends Mock implements Attach {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockTui extends Mock implements Tui {}

void main() {
  group('Finisher', () {
    late MockAttach mockAttach;
    late MockInputOutput mockIo;
    late MockLang mockLang;
    late MockTui mockTui;

    late Finisher finisher;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockAttach = MockAttach();
      mockIo = MockInputOutput();
      mockLang = MockLang();
      mockTui = MockTui();

      finisher = Finisher(
        mockAttach,
        mockIo,
        mockLang,
        mockTui,
      );
    });

    test('call finisher', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(45)).thenReturn('');
      when(() => mockTui.dialog(any(), any(), any(), any()))
          .thenAnswer((final _) async => 1);
      when(() => mockLang.write(46, PrintQuery.normal)).thenReturn('');
      when(mockAttach.successExit).thenReturn(null);

      await finisher();

      verify(mockIo.clear).called(2);
      verify(() => mockLang.write(45)).called(1);
      verify(() => mockTui.dialog(any(), any(), any(), any())).called(1);
      verify(() => mockLang.write(46, PrintQuery.normal)).called(1);
      verify(mockAttach.successExit).called(1);
    });
  });
}

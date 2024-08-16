import 'dart:async' show Timer;

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

final class MockAttach extends Mock implements Attach {}

final class MockInitLang extends Mock implements InitLang {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockTui extends Mock implements Tui {}

final class MockVariables extends Mock implements Variables {}

void main() {
  group('Init', () {
    late MockAttach mockAttach;
    late MockInitLang mockInitLang;
    late MockInputOutput mockInputOutput;
    late MockLang mockLang;
    late MockTui mockTui;
    late MockVariables mockVariables;

    late Init init;

    setUp(() {
      mockAttach = MockAttach();
      mockInitLang = MockInitLang();
      mockInputOutput = MockInputOutput();
      mockLang = MockLang();
      mockVariables = MockVariables();
      mockTui = MockTui();

      init = Init(
        mockAttach,
        mockInitLang,
        mockInputOutput,
        mockLang,
        mockTui,
        mockVariables,
      );
    });

    test('call init successfully, when args is empty, with all restrictions',
        () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(mockLang.assignLang).thenReturn(null);
      when(mockTui.spin).thenReturn(Timer(Duration(), () {}));
      when(() => mockAttach.isLinux).thenReturn(true);
      when(mockInputOutput.checkUid).thenAnswer((final _) async => false);
      when(() => mockAttach.dirExists('/sys/firmware/efi')).thenReturn(false);
      when(() => mockAttach.isx64).thenReturn(false);
      when(() => mockInputOutput.success('pacman'))
          .thenAnswer((final _) async => false);
      when(mockAttach.internetCheck).thenAnswer((final _) async => false);
      when(() => mockLang.write(6, PrintQuery.normal)).thenReturn('');
      when(() => mockLang.write(7, PrintQuery.normal)).thenReturn('');
      when(() => mockLang.write(8, PrintQuery.normal)).thenReturn('');
      when(() => mockLang.write(9, PrintQuery.normal)).thenReturn('');
      when(() => mockInputOutput.call(any())).thenAnswer((final _) async => 0);
      when(() => mockInputOutput.success(any()))
          .thenAnswer((final _) async => false);
      when(() => mockLang.write(10, PrintQuery.normal)).thenReturn('');

      await init([]);

      verify(() => mockInitLang()).called(2);
      verify(mockInputOutput.clear).called(2);
      verify(mockLang.assignLang).called(1);
      verify(mockTui.spin).called(1);
      verify(() => mockAttach.isLinux).called(1);
      verify(mockInputOutput.checkUid).called(1);
      verify(() => mockAttach.dirExists('/sys/firmware/efi')).called(1);
      verify(() => mockAttach.isx64).called(1);
      verify(() => mockInputOutput.success('pacman')).called(1);
      verify(mockAttach.internetCheck).called(1);
      verify(() => mockLang.write(6, PrintQuery.normal)).called(1);
      verify(() => mockLang.write(7, PrintQuery.normal)).called(1);
      verify(() => mockLang.write(8, PrintQuery.normal)).called(1);
      verify(() => mockLang.write(9, PrintQuery.normal)).called(1);
      verify(() => mockInputOutput.call(any())).called(5);
      verify(() => mockInputOutput.success(any())).called(3);
      verify(() => mockLang.write(10, PrintQuery.normal)).called(1);
    });

    test('call init successfully, when args is not empty', () async {
      when(() => mockInitLang()).thenReturn(null);
      when(() => mockVariables.diskenvdev).thenReturn('');
      when(() => mockLang.isEnglish).thenReturn(false);

      await init(['chroot', 'HDD', '1']);

      when(() => mockVariables.diskenvdev).thenReturn('HDD');
      when(() => mockLang.isEnglish).thenReturn(true);

      verify(() => mockInitLang()).called(1);
      expect(mockVariables.diskenvdev, equals('HDD'));
      expect(mockLang.isEnglish, true);
    });
  });
}

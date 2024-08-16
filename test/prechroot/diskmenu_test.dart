import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/prechroot.dart';

final class MockAttach extends Mock implements Attach {}

final class MockColorize extends Mock implements Colorize {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

void main() {
  group('Diskmenu', () {
    late MockAttach mockAttach;
    late MockColorize mockColorize;
    late MockInputOutput mockInputOutput;
    late MockLang mockLang;

    late DiskMenu diskMenu;

    setUpAll(() {
      registerFallbackValue('');
      registerFallbackValue(<String>[]);
    });

    setUp(() {
      mockAttach = MockAttach();
      mockColorize = MockColorize();
      mockInputOutput = MockInputOutput();
      mockLang = MockLang();

      diskMenu = DiskMenu(
        mockAttach,
        mockColorize,
        mockInputOutput,
        mockLang,
      );
    });

    test('call diskmenu when parts is not empty', () async {
      when(mockInputOutput.clear).thenReturn(null);

      when(() => mockInputOutput.syssplit(any()))
          .thenAnswer((final _) async => ['/dev/sda1, /dev/sda2']);
      when(() => mockLang.write(13)).thenReturn('');
      when(() => mockLang.write(11, PrintQuery.normal)).thenReturn('');
      when(() => mockLang.write(12)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockAttach.chooser(any())).thenReturn('/dev/sda1');

      await diskMenu();

      verify(() => mockInputOutput.clear()).called(1);
      verify(() => mockInputOutput.syssplit(any())).called(1);
      verify(() => mockLang.write(13)).called(1);
      verify(() => mockLang.write(12)).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(() => mockAttach.chooser(any())).called(1);
    });

    test('call diskmenu when parts is empty', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockLang.write(13)).thenReturn('');
      when(() => mockInputOutput.syssplit(any()))
          .thenAnswer((final _) async => <String>[]);
      when(() => mockLang.write(11, PrintQuery.normal)).thenReturn('');
      when(() => mockLang.write(12)).thenReturn('');
      when(() => mockAttach.chooser(any())).thenReturn('/dev/sda1');

      await diskMenu();

      verify(() => mockInputOutput.clear()).called(1);
      verify(() => mockInputOutput.syssplit(any())).called(1);
      verify(() => mockLang.write(11, PrintQuery.normal)).called(1);
      verify(() => mockLang.write(12)).called(1);
    });
  });
}

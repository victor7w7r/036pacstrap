import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/prechroot.dart';

final class MockAttach extends Mock implements Attach {}

final class MockColorize extends Mock implements Colorize {}

final class MockDiskformat extends Mock implements Diskformat {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockVariables extends Mock implements Variables {}

void main() {
  group('Partitioning', () {
    late MockAttach mockAttach;
    late MockColorize mockColorize;
    late MockDiskformat mockDiskformat;
    late MockInputOutput mockInputOutput;
    late MockLang mockLang;
    late MockVariables mockVariables;

    late Partitioning partitioning;

    setUpAll(() {
      registerFallbackValue(<String>[]);
      registerFallbackValue('');
    });

    setUp(() {
      mockAttach = MockAttach();
      mockColorize = MockColorize();
      mockDiskformat = MockDiskformat();
      mockInputOutput = MockInputOutput();
      mockLang = MockLang();
      mockVariables = MockVariables();

      partitioning = Partitioning(
        mockAttach,
        mockColorize,
        mockDiskformat,
        mockInputOutput,
        mockLang,
        mockVariables,
      );
    });

    test('call partitioning and choose cgdisk option', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockInputOutput.sys(any()))
          .thenAnswer((final _) async => '100');
      when(() => mockInputOutput.syssplit(any()))
          .thenAnswer((final _) async => ['8300']);
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockColorize.red(any())).thenReturn(null);
      when(() => mockLang.write(12)).thenReturn('12');
      when(() => mockLang.write(21)).thenReturn('21');
      when(() => mockLang.write(22)).thenReturn('22');
      when(() => mockLang.write(23)).thenReturn('23');
      when(() => mockLang.write(24)).thenReturn('24');
      when(() => mockLang.write(25)).thenReturn('25');
      when(() => mockLang.write(26)).thenReturn('26');

      when(() => mockInputOutput.coderes(any()))
          .thenAnswer((final _) async => 0);
      when(() => mockAttach.chooser(any())).thenReturn('21');

      await partitioning.call(true);

      verify(mockInputOutput.clear).called(2);
      verify(() => mockVariables.disk).called(5);
      verify(() => mockInputOutput.syssplit(any())).called(1);
      verify(() => mockInputOutput.sys(any())).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(() => mockColorize.red(any())).called(1);
      verify(() => mockLang.write(12)).called(1);
      verify(() => mockInputOutput.coderes(any())).called(1);
    });

    test('call partitioning and choose parted option with nvme', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/nvme0n1');
      when(() => mockInputOutput.sys(any()))
          .thenAnswer((final _) async => '100');
      when(() => mockInputOutput.syssplit(any()))
          .thenAnswer((final _) async => ['8300']);
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockColorize.red(any())).thenReturn(null);
      when(() => mockLang.write(12)).thenReturn('12');
      when(() => mockLang.write(21)).thenReturn('21');
      when(() => mockLang.write(22)).thenReturn('22');
      when(() => mockLang.write(23)).thenReturn('23');
      when(() => mockLang.write(24)).thenReturn('24');
      when(() => mockLang.write(25)).thenReturn('25');
      when(() => mockLang.write(26)).thenReturn('26');

      when(() => mockInputOutput.coderes(any()))
          .thenAnswer((final _) async => 0);
      when(() => mockAttach.chooser(any())).thenReturn('22');

      await partitioning.call(true);

      verify(mockInputOutput.clear).called(2);
      verify(() => mockVariables.disk).called(5);
      verify(() => mockInputOutput.syssplit(any())).called(1);
      verify(() => mockInputOutput.sys(any())).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(() => mockColorize.red(any())).called(1);
      verify(() => mockLang.write(12)).called(1);
      verify(() => mockInputOutput.coderes(any())).called(1);
    });

    test('call partitioning and choose erase all the disk', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/nvme0n1');
      when(() => mockInputOutput.sys(any()))
          .thenAnswer((final _) async => '100');
      when(() => mockInputOutput.syssplit(any()))
          .thenAnswer((final _) async => ['8300']);
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockColorize.red(any())).thenReturn(null);
      when(() => mockLang.write(12)).thenReturn('12');
      when(() => mockLang.write(21)).thenReturn('21');
      when(() => mockLang.write(22)).thenReturn('22');
      when(() => mockLang.write(23)).thenReturn('23');
      when(() => mockLang.write(24)).thenReturn('24');
      when(() => mockLang.write(25)).thenReturn('25');
      when(() => mockLang.write(26)).thenReturn('26');
      when(() => mockInputOutput.call(any())).thenAnswer((final _) async => 0);
      when(() => mockAttach.chooser(any())).thenReturn('23');
      when(() => mockVariables.rootpart).thenReturn('');
      when(() => mockDiskformat(any())).thenAnswer((final _) async => 0);

      await partitioning.call(true);

      verify(mockInputOutput.clear).called(1);
      verify(() => mockVariables.disk).called(7);
      verify(() => mockInputOutput.syssplit(any())).called(1);
      verify(() => mockInputOutput.sys(any())).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(() => mockColorize.red(any())).called(1);
      verify(() => mockLang.write(12)).called(1);
      verify(() => mockInputOutput.call(any())).called(1);
      verify(() => mockDiskformat(any())).called(1);
    });

    test('call partitioning, press the exit option', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockInputOutput.sys(any()))
          .thenAnswer((final _) async => '100');
      when(() => mockInputOutput.syssplit(any()))
          .thenAnswer((final _) async => ['8300']);
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockColorize.red(any())).thenReturn(null);
      when(() => mockLang.write(12)).thenReturn('12');
      when(() => mockLang.write(21)).thenReturn('21');
      when(() => mockLang.write(22)).thenReturn('22');
      when(() => mockLang.write(23)).thenReturn('23');
      when(() => mockLang.write(24)).thenReturn('24');
      when(() => mockLang.write(25)).thenReturn('25');
      when(() => mockLang.write(26)).thenReturn('26');
      when(() => mockAttach.chooser(any())).thenReturn('24');
      when(mockAttach.successExit).thenReturn(null);

      await partitioning.call(true);

      verify(mockInputOutput.clear).called(2);
      verify(() => mockVariables.disk).called(4);
      verify(() => mockInputOutput.syssplit(any())).called(1);
      verify(() => mockInputOutput.sys(any())).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(() => mockColorize.red(any())).called(1);
      verify(() => mockLang.write(12)).called(1);
      verify(mockAttach.successExit).called(1);
    });

    test('call partitioning, with the linux partition option', () async {
      when(mockInputOutput.clear).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockInputOutput.sys(any()))
          .thenAnswer((final _) async => '100');
      when(() => mockInputOutput.syssplit(any()))
          .thenAnswer((final _) async => ['8300']);
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockColorize.red(any())).thenReturn(null);
      when(() => mockLang.write(12)).thenReturn('12');
      when(() => mockLang.write(21)).thenReturn('21');
      when(() => mockLang.write(22)).thenReturn('22');
      when(() => mockLang.write(23)).thenReturn('23');
      when(() => mockLang.write(24)).thenReturn('24');
      when(() => mockLang.write(25)).thenReturn('25');
      when(() => mockLang.write(26)).thenReturn('26');
      when(() => mockAttach.chooser(any())).thenReturn('/dev/sda1');
      when(() => mockVariables.rootpart).thenReturn('');
      when(() => mockDiskformat(any())).thenAnswer((final _) async => 0);

      await partitioning.call(true);

      verify(mockInputOutput.clear).called(1);
      verify(() => mockVariables.disk).called(4);
      verify(() => mockInputOutput.syssplit(any())).called(1);
      verify(() => mockInputOutput.sys(any())).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(() => mockColorize.red(any())).called(1);
      verify(() => mockLang.write(12)).called(1);
      verify(() => mockDiskformat(any())).called(1);
    });
  });
}

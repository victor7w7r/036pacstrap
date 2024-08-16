import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/prechroot/diskinit.dart';

final class MockAttach extends Mock implements Attach {}

final class MockColorize extends Mock implements Colorize {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockMessages extends Mock implements Messages {}

final class MockVariables extends Mock implements Variables {}

void main() {
  group('DiskInit', () {
    late MockAttach mockAttach;
    late MockColorize mockColorize;
    late MockInputOutput mockIo;
    late MockLang mockLang;
    late MockMessages mockMessages;
    late MockVariables mockVariables;

    late DiskInit diskInit;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockAttach = MockAttach();
      mockColorize = MockColorize();
      mockIo = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();
      mockVariables = MockVariables();

      diskInit = DiskInit(
        mockAttach,
        mockColorize,
        mockIo,
        mockLang,
        mockMessages,
        mockVariables,
      );
    });

    test(
        'call diskinit when SSD disk has different gpt table, '
        'pressing confirm for erase', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda'))
          .thenAnswer((final _) async => 'dos');
      when(() => mockLang.write(14)).thenReturn('');
      when(() => mockLang.write(15)).thenReturn('');
      when(() => mockLang.write(16)).thenReturn('');
      when(mockAttach.stdYesNo).thenReturn(true);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .thenAnswer((final _) async => '');
      when(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"))
          .thenAnswer((final _) async => '0');
      when(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).thenAnswer(
        (final _) async => 'sda',
      );
      when(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).thenAnswer(
        (final _) async => '0',
      );
      when(() => mockIo.syswline(any())).thenAnswer((final _) async => '0');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockVariables.diskenvdev).thenReturn('SSD');

      await diskInit('/dev/sda');

      verify(mockIo.clear).called(2);
      verify(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda')).called(1);
      verify(() => mockLang.write(14)).called(1);
      verify(() => mockLang.write(15)).called(1);
      verify(() => mockLang.write(16)).called(1);
      verify(mockAttach.stdYesNo).called(1);
      verify(() => mockIo.call(any())).called(3);
      verify(() => mockIo.coderes(any())).called(1);
      verify(() => mockIo.syswline(any())).called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"));
      verify(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).called(1);
      verify(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).called(1);
    });

    test(
        'call diskinit when SSD disk has different gpt table, '
        'pressing confirm for exit', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda'))
          .thenAnswer((final _) async => 'dos');
      when(() => mockLang.write(14)).thenReturn('');
      when(() => mockLang.write(15)).thenReturn('');
      when(() => mockLang.write(16)).thenReturn('');
      when(mockAttach.stdYesNo).thenReturn(false);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .thenAnswer((final _) async => '');
      when(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"))
          .thenAnswer((final _) async => '0');
      when(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).thenAnswer(
        (final _) async => 'sda',
      );
      when(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).thenAnswer(
        (final _) async => '0',
      );
      when(() => mockIo.syswline(any())).thenAnswer((final _) async => '0');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockVariables.diskenvdev).thenReturn('SSD');
      when(() => mockAttach.successExit()).thenReturn(null);

      await diskInit('/dev/sda');

      verify(mockIo.clear).called(2);
      verify(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda')).called(1);
      verify(() => mockLang.write(14)).called(1);
      verify(() => mockLang.write(15)).called(1);
      verify(() => mockLang.write(16)).called(1);
      verify(mockAttach.stdYesNo).called(1);
      verify(() => mockIo.call(any())).called(2);
      verify(() => mockIo.coderes(any())).called(1);
      verify(() => mockIo.syswline(any())).called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"));
      verify(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).called(1);
      verify(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).called(1);
      verify(() => mockAttach.successExit()).called(1);
    });

    test(
        'call diskinit when SSD disk has gpt table, '
        'the disk is empty '
        'pressing confirm for erase', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda'))
          .thenAnswer((final _) async => 'gpt');
      when(() => mockLang.write(18)).thenReturn('');
      when(() => mockLang.write(15)).thenReturn('');
      when(() => mockLang.write(16)).thenReturn('');
      when(mockAttach.stdYesNo).thenReturn(true);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .thenAnswer((final _) async => '');
      when(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"))
          .thenAnswer((final _) async => '1');
      when(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).thenAnswer(
        (final _) async => 'sda',
      );
      when(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).thenAnswer(
        (final _) async => '0',
      );
      when(() => mockIo.syswline(any())).thenAnswer((final _) async => '0');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockVariables.diskenvdev).thenReturn('SSD');

      await diskInit('/dev/sda');

      verify(mockIo.clear).called(2);
      verify(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda')).called(1);
      verify(() => mockLang.write(18)).called(1);
      verify(() => mockLang.write(15)).called(1);
      verify(() => mockLang.write(16)).called(1);
      verify(mockAttach.stdYesNo).called(1);
      verify(() => mockIo.call(any())).called(3);
      verify(() => mockIo.coderes(any())).called(1);
      verify(() => mockIo.syswline(any())).called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"));
      verify(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).called(1);
      verify(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).called(1);
    });

    test(
        'call diskinit when SSD disk has gpt table, '
        'the disk is empty '
        'pressing confirm for exit', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda'))
          .thenAnswer((final _) async => 'gpt');
      when(() => mockLang.write(18)).thenReturn('');
      when(() => mockLang.write(15)).thenReturn('');
      when(mockAttach.stdYesNo).thenReturn(false);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .thenAnswer((final _) async => '');
      when(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"))
          .thenAnswer((final _) async => '1');
      when(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).thenAnswer(
        (final _) async => 'sda',
      );
      when(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).thenAnswer(
        (final _) async => '0',
      );
      when(() => mockIo.syswline(any())).thenAnswer((final _) async => '0');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockVariables.diskenvdev).thenReturn('SSD');
      when(() => mockAttach.successExit()).thenReturn(null);

      await diskInit('/dev/sda');

      verify(mockIo.clear).called(2);
      verify(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda')).called(1);
      verify(() => mockLang.write(18)).called(1);
      verify(() => mockLang.write(15)).called(1);
      verify(mockAttach.stdYesNo).called(1);
      verify(() => mockIo.call(any())).called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"));
      verify(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).called(1);
      verify(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).called(1);
      verify(() => mockAttach.successExit()).called(1);
    });

    test(
        'call diskinit when SSD disk has gpt table, '
        'the disk has efi and other partitions, '
        'but efi partition is not at the beginning, '
        'pressing confirm for erase', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda'))
          .thenAnswer((final _) async => 'gpt');
      when(() => mockLang.write(19)).thenReturn('');
      when(() => mockLang.write(15)).thenReturn('');
      when(() => mockLang.write(16)).thenReturn('');
      when(mockAttach.stdYesNo).thenReturn(true);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .thenAnswer((final _) async => '/dev/sda1');
      when(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"))
          .thenAnswer((final _) async => '1');
      when(() => mockIo.sys("echo /dev/sda1 | sed -ne '/[[:alpha:]]1/p'"))
          .thenAnswer((final _) async => '');
      when(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).thenAnswer(
        (final _) async => 'sda',
      );
      when(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).thenAnswer(
        (final _) async => '0',
      );
      when(() => mockIo.syswline(any())).thenAnswer((final _) async => '0');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockColorize.red(any())).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockVariables.diskenvdev).thenReturn('SSD');

      await diskInit('/dev/sda');

      verify(mockIo.clear).called(2);
      verify(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda')).called(1);
      verify(() => mockLang.write(19)).called(1);
      verify(() => mockLang.write(15)).called(1);
      verify(() => mockLang.write(16)).called(1);
      verify(mockAttach.stdYesNo).called(1);
      verify(() => mockIo.call(any())).called(4);
      verify(() => mockIo.coderes(any())).called(1);
      verify(() => mockIo.syswline(any())).called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"));
      verify(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).called(1);
      verify(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).called(1);
    });

    test(
        'call diskinit when SSD disk has gpt table, '
        'the disk has efi and other partitions, '
        'but efi partition is not at the beginning, '
        'pressing for exit', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda'))
          .thenAnswer((final _) async => 'gpt');
      when(() => mockLang.write(19)).thenReturn('');
      when(() => mockLang.write(15)).thenReturn('');
      when(mockAttach.stdYesNo).thenReturn(false);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .thenAnswer((final _) async => '/dev/sda1');
      when(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"))
          .thenAnswer((final _) async => '1');
      when(() => mockIo.sys("echo /dev/sda1 | sed -ne '/[[:alpha:]]1/p'"))
          .thenAnswer((final _) async => '');
      when(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).thenAnswer(
        (final _) async => 'sda',
      );
      when(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).thenAnswer(
        (final _) async => '0',
      );
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockColorize.red(any())).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockVariables.diskenvdev).thenReturn('SSD');

      await diskInit('/dev/sda');

      verify(mockIo.clear).called(2);
      verify(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda')).called(1);
      verify(() => mockLang.write(19)).called(1);
      verify(() => mockLang.write(15)).called(1);
      verify(mockAttach.stdYesNo).called(1);
      verify(() => mockIo.call(any())).called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"));
      verify(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).called(1);
      verify(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).called(1);
    });

    test(
        'call diskinit when SSD disk has gpt table, '
        'the disk has efi and other partitions, '
        'but efi partition is at the beginning', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda'))
          .thenAnswer((final _) async => 'gpt');
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .thenAnswer((final _) async => '/dev/sda1');
      when(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"))
          .thenAnswer((final _) async => '1');
      when(() => mockIo.sys("echo /dev/sda1 | sed -ne '/[[:alpha:]]1/p'"))
          .thenAnswer((final _) async => 'efi');
      when(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).thenAnswer(
        (final _) async => 'sda',
      );
      when(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).thenAnswer(
        (final _) async => '0',
      );
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockColorize.red(any())).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/sda');
      when(() => mockVariables.diskenvdev).thenReturn('SSD');

      await diskInit('/dev/sda');

      verify(mockIo.clear).called(1);
      verify(() => mockIo.sys('blkid -o value -s PTTYPE /dev/sda')).called(1);
      verify(() => mockIo.call(any())).called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | sed -ne '/EFI/p'"))
          .called(1);
      verify(() => mockIo.sys("fdisk -l /dev/sda | grep -c '^/dev/sda[0-9]'"));
      verify(() => mockIo.sys('echo /dev/sda | cut -d "/" -f3')).called(1);
      verify(() => mockIo.sys('cat /sys/block/sda/queue/rotational')).called(1);
    });

    test(
        'call diskinit when SSD disk has gpt table, '
        'the disk has only the efi partition ', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockIo.sys('blkid -o value -s PTTYPE /dev/hda'))
          .thenAnswer((final _) async => 'gpt');
      when(() => mockIo.sys("fdisk -l /dev/hda | sed -ne '/EFI/p'"))
          .thenAnswer((final _) async => '/dev/hda1');
      when(() => mockIo.sys("fdisk -l /dev/hda | grep -c '^/dev/hda[0-9]'"))
          .thenAnswer((final _) async => '0');
      when(() => mockIo.sys("echo /dev/hda1 | sed -ne '/[[:alpha:]]1/p'"))
          .thenAnswer((final _) async => 'efi');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockColorize.red(any())).thenReturn(null);
      when(() => mockVariables.disk).thenReturn('/dev/hda');
      when(() => mockVariables.diskenvdev).thenReturn('SSD');

      await diskInit('/dev/hda');

      verify(mockIo.clear).called(1);
      verify(() => mockIo.sys('blkid -o value -s PTTYPE /dev/hda')).called(1);
      verify(() => mockIo.sys("fdisk -l /dev/hda | sed -ne '/EFI/p'"))
          .called(1);
      verify(() => mockIo.sys("fdisk -l /dev/hda | grep -c '^/dev/hda[0-9]'"));
    });
  });
}

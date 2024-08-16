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
  group('Drivers', () {
    late MockAttach mockAttach;
    late MockColorize mockColorize;
    late MockInputOutput mockIo;
    late MockLang mockLang;
    late MockMessages mockMessages;

    late Drivers drivers;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockAttach = MockAttach();
      mockColorize = MockColorize();
      mockIo = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();

      drivers = Drivers(
        mockAttach,
        mockColorize,
        mockIo,
        mockLang,
        mockMessages,
      );
    });

    test('call drivers with Intel choose', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(40)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(
        () => mockAttach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']),
      ).thenReturn('Intel');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);

      await drivers();

      verify(mockIo.clear).called(2);
      verify(() => mockLang.write(40)).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(
        () => mockAttach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']),
      ).called(1);
      verify(() => mockIo.coderes(any())).called(1);
      verify(mockMessages.okMessage).called(1);
    });

    test('call drivers with ATI choose', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(40)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(
        () => mockAttach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']),
      ).thenReturn('ATI');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);

      await drivers();

      verify(mockIo.clear).called(2);
      verify(() => mockLang.write(40)).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(
        () => mockAttach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']),
      ).called(1);
      verify(() => mockIo.coderes(any())).called(1);
      verify(mockMessages.okMessage).called(1);
    });
    test('call drivers with AMD choose', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(40)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(
        () => mockAttach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']),
      ).thenReturn('AMD');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);

      await drivers();

      verify(mockIo.clear).called(2);
      verify(() => mockLang.write(40)).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(
        () => mockAttach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']),
      ).called(1);
      verify(() => mockIo.coderes(any())).called(1);
      verify(mockMessages.okMessage).called(1);
    });

    test('call drivers with NVIDIA choose', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(40)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(
        () => mockAttach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']),
      ).thenReturn('NVIDIA');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);

      await drivers();

      verify(mockIo.clear).called(2);
      verify(() => mockLang.write(40)).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(
        () => mockAttach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']),
      ).called(1);
      verify(() => mockIo.coderes(any())).called(1);
      verify(mockMessages.okMessage).called(1);
    });

    test('call drivers with VMware choose', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(40)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(
        () => mockAttach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']),
      ).thenReturn('VMware');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);

      await drivers();

      verify(mockIo.clear).called(2);
      verify(() => mockLang.write(40)).called(1);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(
        () => mockAttach.stdChoose(['Intel', 'ATI', 'AMD', 'NVIDIA', 'VMware']),
      ).called(1);
      verify(() => mockIo.coderes(any())).called(2);
      verify(mockMessages.okMessage).called(1);
    });
  });
}

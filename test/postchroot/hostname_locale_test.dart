import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/postchroot.dart';

final class MockAttach extends Mock implements Attach {}

final class MockColorize extends Mock implements Colorize {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockTui extends Mock implements Tui {}

void main() {
  group('HostnameLocale', () {
    late MockAttach mockAttach;
    late MockColorize mockColorize;
    late MockInputOutput mockIo;
    late MockLang mockLang;
    late MockTui mockTui;

    late HostnameLocale hostnameLocale;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockAttach = MockAttach();
      mockColorize = MockColorize();
      mockIo = MockInputOutput();
      mockLang = MockLang();
      mockTui = MockTui();

      hostnameLocale = HostnameLocale(
        mockAttach,
        mockColorize,
        mockIo,
        mockLang,
        mockTui,
      );
    });

    test('call hostnamer', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(34)).thenReturn('');
      when(() => mockAttach.readInputSync(''))
          .thenAnswer((final _) async => '');
      when(() => mockAttach.writeFile('/etc/hostname', any())).thenReturn(null);
      when(() => mockAttach.appendFile('/etc/hosts', any())).thenReturn(null);

      await hostnameLocale.hostnamer();

      verify(mockIo.clear).called(1);
      verify(() => mockLang.write(34)).called(1);
      verify(() => mockAttach.readInputSync('')).called(1);
      verify(() => mockAttach.writeFile('/etc/hostname', any())).called(1);
      verify(() => mockAttach.appendFile('/etc/hosts', any())).called(1);
    });

    test('call localer', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(35)).thenReturn('');
      when(() => mockTui.dialog(any(), any(), any(), any()))
          .thenAnswer((final _) async => 1);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockLang.write(36)).thenReturn('');
      when(() => mockLang.write(12)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(() => mockLang.chooser(['es_ES', 'en_US'])).thenReturn('');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockAttach.writeFile(any(), any())).thenReturn(null);

      await hostnameLocale.localer();

      verify(mockIo.clear).called(3);
      verify(() => mockLang.write(35)).called(1);
      verify(() => mockTui.dialog(any(), any(), any(), any())).called(1);
      verify(() => mockIo.call(any())).called(3);
      verify(() => mockLang.write(36)).called(1);
      verify(() => mockLang.write(12)).called(1);
      verify(() => mockLang.chooser(['es_ES', 'en_US'])).called(1);
      verify(() => mockIo.coderes(any())).called(1);
      verify(() => mockAttach.writeFile('/etc/locale.conf', any())).called(1);
    });
  });
}

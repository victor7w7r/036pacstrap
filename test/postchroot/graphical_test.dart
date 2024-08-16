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

final class MockTui extends Mock implements Tui {}

final class MockVariables extends Mock implements Variables {}

void main() {
  group('Graphical', () {
    late MockAttach mockAttach;
    late MockColorize mockColorize;
    late MockInputOutput mockIo;
    late MockLang mockLang;
    late MockMessages mockMessages;
    late MockTui mockTui;
    late MockVariables mockVariables;

    late Graphical graphical;

    setUpAll(() {
      registerFallbackValue('');
    });

    setUp(() {
      mockAttach = MockAttach();
      mockColorize = MockColorize();
      mockIo = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();
      mockTui = MockTui();
      mockVariables = MockVariables();

      graphical = Graphical(
        mockAttach,
        mockColorize,
        mockIo,
        mockLang,
        mockMessages,
        mockTui,
        mockVariables,
      );
    });

    test('call graphical with xfce choose', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockTui.dialog(any(), any(), any(), any()))
          .thenAnswer((final _) async => 1);
      when(() => mockLang.write(39)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(
        () =>
            mockAttach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']),
      ).thenReturn('XFCE');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);
      when(() => mockVariables.xfce).thenReturn(true);

      await graphical();

      verify(mockIo.clear).called(3);
      verify(() => mockTui.dialog(any(), any(), any(), any())).called(1);
      verify(() => mockLang.write(39)).called(2);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(
        () =>
            mockAttach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']),
      ).called(1);
      verify(() => mockIo.coderes(any())).called(3);
      verify(mockMessages.okMessage).called(1);
    });

    test('call graphical with gnome choose', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockTui.dialog(any(), any(), any(), any()))
          .thenAnswer((final _) async => 1);
      when(() => mockLang.write(39)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(
        () =>
            mockAttach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']),
      ).thenReturn('GNOME');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);
      when(() => mockVariables.xfce).thenReturn(true);

      await graphical();

      verify(mockIo.clear).called(3);
      verify(() => mockTui.dialog(any(), any(), any(), any())).called(1);
      verify(() => mockLang.write(39)).called(2);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(
        () =>
            mockAttach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']),
      ).called(1);
      verify(() => mockIo.coderes(any())).called(4);
      verify(mockMessages.okMessage).called(1);
    });

    test('call graphical with plasma choose', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockTui.dialog(any(), any(), any(), any()))
          .thenAnswer((final _) async => 1);
      when(() => mockLang.write(39)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(
        () =>
            mockAttach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']),
      ).thenReturn('Plasma');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);
      when(() => mockVariables.xfce).thenReturn(true);

      await graphical();

      verify(mockIo.clear).called(3);
      verify(() => mockTui.dialog(any(), any(), any(), any())).called(1);
      verify(() => mockLang.write(39)).called(2);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(
        () =>
            mockAttach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']),
      ).called(1);
      verify(() => mockIo.coderes(any())).called(4);
      verify(mockMessages.okMessage).called(1);
    });

    test('call graphical with xorg choose', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockTui.dialog(any(), any(), any(), any()))
          .thenAnswer((final _) async => 1);
      when(() => mockLang.write(39)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(
        () =>
            mockAttach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']),
      ).thenReturn('XORG');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 1);
      when(mockMessages.okMessage).thenReturn(null);
      when(() => mockVariables.xfce).thenReturn(true);

      await graphical();

      verify(mockIo.clear).called(3);
      verify(() => mockTui.dialog(any(), any(), any(), any())).called(1);
      verify(() => mockLang.write(39)).called(2);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(
        () =>
            mockAttach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']),
      ).called(1);
      verify(() => mockIo.coderes(any())).called(1);
      verify(mockMessages.okMessage).called(1);
    });

    test('call graphical with nogui choose', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockTui.dialog(any(), any(), any(), any()))
          .thenAnswer((final _) async => 1);
      when(() => mockLang.write(39)).thenReturn('');
      when(() => mockColorize.cyan(any())).thenReturn(null);
      when(
        () =>
            mockAttach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']),
      ).thenReturn('NOGUI');

      await graphical();

      verify(mockIo.clear).called(3);
      verify(() => mockTui.dialog(any(), any(), any(), any())).called(1);
      verify(() => mockLang.write(39)).called(2);
      verify(() => mockColorize.cyan(any())).called(1);
      verify(
        () =>
            mockAttach.stdChoose(['XFCE', 'GNOME', 'Plasma', 'XORG', 'NOGUI']),
      ).called(1);
    });
  });
}

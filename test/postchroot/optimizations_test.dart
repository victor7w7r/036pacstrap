import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/postchroot.dart';

final class MockAttach extends Mock implements Attach {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLang extends Mock implements Lang {}

final class MockMessages extends Mock implements Messages {}

void main() {
  group('Optimizations', () {
    late MockAttach mockAttach;
    late MockInputOutput mockIo;
    late MockLang mockLang;
    late MockMessages mockMessages;

    late Optimizations optimizations;

    setUp(() {
      mockAttach = MockAttach();
      mockIo = MockInputOutput();
      mockLang = MockLang();
      mockMessages = MockMessages();

      optimizations = Optimizations(
        mockAttach,
        mockIo,
        mockLang,
        mockMessages,
      );
    });

    test('call optimizations', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockLang.write(44, PrintQuery.normal)).thenReturn('');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockAttach.writeFile(any(), any())).thenReturn(null);
      when(() => mockMessages.okMessage()).thenReturn(null);

      await optimizations.call();

      verify(mockIo.clear).called(1);
      verify(() => mockLang.write(44, PrintQuery.normal)).called(1);
      verify(() => mockIo.coderes(any())).called(2);
      verify(() => mockIo.call(any())).called(1);
      verify(() => mockAttach.writeFile(any(), any())).called(1);
      verify(mockMessages.okMessage).called(1);
    });
  });
}

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/postchroot.dart';

final class MockAttach extends Mock implements Attach {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockMessages extends Mock implements Messages {}

final class MockVariables extends Mock implements Variables {}

void main() {
  group('Swapper', () {
    late MockAttach mockAttach;
    late MockInputOutput mockIo;
    late MockMessages mockMessages;
    late MockVariables mockVariables;

    late Swapper swapper;

    setUp(() {
      mockAttach = MockAttach();
      mockIo = MockInputOutput();
      mockMessages = MockMessages();
      mockVariables = MockVariables();

      swapper = Swapper(
        mockAttach,
        mockIo,
        mockMessages,
        mockVariables,
      );
    });

    test('call swapper when disk is HDD', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockMessages.header('SWAPPING')).thenReturn(null);
      when(() => mockVariables.diskenvdev).thenReturn('HDD');
      when(() => mockAttach.appendFile(any(), any())).thenReturn(null);
      when(() => mockMessages.okMessage()).thenReturn(null);

      await swapper.call();

      verify(mockIo.clear).called(1);
      verify(() => mockMessages.header('SWAPPING')).called(1);
      verify(() => mockVariables.diskenvdev).called(1);
      when(() => mockAttach.appendFile(any(), any())).thenReturn(null);
      verify(mockMessages.okMessage).called(1);
    });

    test('call swapper when disk is SSD', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockMessages.header('SWAPPING')).thenReturn(null);
      when(() => mockVariables.diskenvdev).thenReturn('SSD');
      when(() => mockVariables.sudouser).thenReturn('victor7w7r');
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(mockMessages.okMessage).thenReturn(null);

      await swapper.call();

      verify(mockIo.clear).called(1);
      verify(() => mockMessages.header('SWAPPING')).called(1);
      verify(() => mockVariables.diskenvdev).called(1);
      verify(() => mockIo.coderes(any())).called(2);
      verify(() => mockIo.call(any())).called(2);
      verify(mockMessages.okMessage).called(1);
    });
  });
}

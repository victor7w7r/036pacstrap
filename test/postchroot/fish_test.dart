import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/postchroot.dart';

final class MockInputOutput extends Mock implements InputOutput {}

final class MockMessages extends Mock implements Messages {}

final class MockVariables extends Mock implements Variables {}

void main() {
  group('Fish', () {
    late MockInputOutput mockIo;
    late MockMessages mockMessages;
    late MockVariables mockVariables;

    late Fish fish;

    setUp(() {
      mockIo = MockInputOutput();
      mockMessages = MockMessages();
      mockVariables = MockVariables();

      fish = Fish(
        mockIo,
        mockMessages,
        mockVariables,
      );
    });

    test('call fish', () async {
      when(mockIo.clear).thenReturn(null);
      when(() => mockMessages.header('FISH')).thenReturn(null);
      when(() => mockIo.coderes(any())).thenAnswer((final _) async => 0);
      when(() => mockIo.call(any())).thenAnswer((final _) async => 0);
      when(() => mockVariables.sudouser).thenReturn('');
      when(mockMessages.okMessage).thenReturn(null);

      await fish();

      verify(mockIo.clear).called(2);
      verify(() => mockMessages.header('FISH')).called(1);
      verify(() => mockIo.coderes(any())).called(3);
      verify(() => mockIo.call(any())).called(8);
      verify(mockMessages.okMessage).called(1);
    });
  });
}

// ignore_for_file: lines_longer_than_80_chars, no_adjacent_strings_in_list

import 'package:test/test.dart';

import 'package:pacstrap/pacstrap.dart';

void main() {
  group('Variables', () {
    late Variables variables;

    setUp(() => variables = Variables());

    test('test variables', () {
      expect(variables.disk, '');
      expect(variables.diskenvdev, '');
      expect(variables.efipart, '');
      expect(variables.rootpart, '');
      expect(variables.sudouser, '');
      expect(variables.swappart, '');
      expect(variables.xfce, false);
    });
  });
}

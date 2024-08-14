// ignore_for_file: lines_longer_than_80_chars, no_adjacent_strings_in_list

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';
import 'package:pacstrap/postchroot/postchroot.dart';
import 'package:pacstrap/prechroot/prechroot.dart';

final class MockAur extends Mock implements Aur {}

final class MockBlackarch extends Mock implements Blackarch {}

final class MockBrew extends Mock implements Brew {}

final class MockConfigurator extends Mock implements Configurator {}

final class MockDiskinit extends Mock implements DiskInit {}

final class MockDiskmenu extends Mock implements DiskMenu {}

final class MockDrivers extends Mock implements Drivers {}

final class MockFinisher extends Mock implements Finisher {}

final class MockFish extends Mock implements Fish {}

final class MockGraphical extends Mock implements Graphical {}

final class MockHostnameLocale extends Mock implements HostnameLocale {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockNewuser extends Mock implements Newuser {}

final class MockOptimizations extends Mock implements Optimizations {}

final class MockPartitioning extends Mock implements Partitioning {}

final class MockSwapper extends Mock implements Swapper {}

final class MockVariables extends Mock implements Variables {}

final class MockXfcetemplate extends Mock implements Xfcetemplate {}

void main() {
  group('App', () {
    late MockAur aur;
    late MockBlackarch blackarch;
    late MockBrew brew;
    late MockConfigurator configurator;
    late MockDiskinit diskinit;
    late MockDiskmenu diskmenu;
    late MockDrivers drivers;
    late MockFinisher finisher;
    late MockFish fish;
    late MockGraphical graphical;
    late MockHostnameLocale hostnameLocale;
    late MockInputOutput io;
    late MockNewuser newuser;
    late MockOptimizations optimizations;
    late MockPartitioning partitioning;
    late MockSwapper swapper;
    late MockVariables variables;
    late MockXfcetemplate xfceTemplate;

    late App app;

    setUp(() {
      aur = MockAur();
      blackarch = MockBlackarch();
      brew = MockBrew();
      configurator = MockConfigurator();
      diskinit = MockDiskinit();
      diskmenu = MockDiskmenu();
      drivers = MockDrivers();
      finisher = MockFinisher();
      fish = MockFish();
      graphical = MockGraphical();
      hostnameLocale = MockHostnameLocale();
      io = MockInputOutput();
      newuser = MockNewuser();
      optimizations = MockOptimizations();
      partitioning = MockPartitioning();
      swapper = MockSwapper();
      variables = MockVariables();
      xfceTemplate = MockXfcetemplate();

      app = App(
        aur,
        blackarch,
        brew,
        configurator,
        hostnameLocale,
        diskinit,
        diskmenu,
        drivers,
        finisher,
        graphical,
        fish,
        io,
        newuser,
        optimizations,
        partitioning,
        swapper,
        variables,
        xfceTemplate,
      );
    });

    test('corechroot', () async {
      when(() => configurator()).thenAnswer((final _) async {});
      when(() => hostnameLocale.hostnamer()).thenAnswer((final _) async {});
      when(() => hostnameLocale.localer()).thenAnswer((final _) async {});
      when(() => newuser()).thenAnswer((final _) async {});
      when(() => graphical()).thenAnswer((final _) async {});
      when(() => drivers()).thenAnswer((final _) async {});
      when(() => aur()).thenAnswer((final _) async {});
      when(() => blackarch()).thenAnswer((final _) async {});
      when(() => brew()).thenAnswer((final _) async {});
      when(() => fish()).thenAnswer((final _) async {});
      when(() => swapper()).thenAnswer((final _) async {});
      when(() => variables.xfce).thenReturn(true);
      when(() => xfceTemplate()).thenAnswer((final _) async {});
      when(() => optimizations()).thenAnswer((final _) async {});
      when(() => finisher()).thenAnswer((final _) async {});

      await app.corechroot();

      verify(() => configurator()).called(1);
      verify(() => hostnameLocale.hostnamer()).called(1);
      verify(() => hostnameLocale.localer()).called(1);
      verify(() => newuser()).called(1);
      verify(() => graphical()).called(1);
      verify(() => drivers()).called(1);
      verify(() => aur()).called(1);
      verify(() => blackarch()).called(1);
      verify(() => brew()).called(1);
      verify(() => fish()).called(1);
      verify(() => swapper()).called(1);
      verify(() => xfceTemplate()).called(1);
      verify(() => optimizations()).called(1);
      verify(() => finisher()).called(1);
    });

    test('corelive', () async {
      when(io.clear).thenReturn(null);
      when(() => diskmenu()).thenAnswer((final _) async => '/dev/sda');
      when(() => diskinit('/dev/sda')).thenAnswer((final _) async {});
      when(() => partitioning()).thenAnswer((final _) async {});

      await app.corelive();

      verify(io.clear).called(1);
      verify(() => diskmenu()).called(1);
      verify(() => diskinit('/dev/sda')).called(1);
      verify(() => partitioning()).called(1);
    });
  });
}

import 'package:injectable/injectable.dart' show injectable;
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/postchroot/postchroot.dart';
import 'package:pacstrap/prechroot/prechroot.dart';
import 'package:pacstrap/variables.dart';

@injectable
class App {
  const App(
    this._aur,
    this._blackarch,
    this._brew,
    this._configurator,
    this._hostnameLocale,
    this._diskinit,
    this._diskmenu,
    this._drivers,
    this._finisher,
    this._graphical,
    this._fish,
    this._io,
    this._newuser,
    this._optimizations,
    this._partitioning,
    this._swapper,
    this._variables,
    this._xfceTemplate,
  );

  final Aur _aur;
  final Blackarch _blackarch;
  final Brew _brew;
  final Configurator _configurator;
  final DiskInit _diskinit;
  final DiskMenu _diskmenu;
  final Drivers _drivers;
  final Finisher _finisher;
  final Fish _fish;
  final Graphical _graphical;
  final HostnameLocale _hostnameLocale;
  final InputOutput _io;
  final Newuser _newuser;
  final Optimizations _optimizations;
  final Partitioning _partitioning;
  final Swapper _swapper;
  final Variables _variables;
  final Xfcetemplate _xfceTemplate;

  Future<void> corechroot() async {
    await _configurator();
    await _hostnameLocale.hostnamer();
    await _hostnameLocale.localer();
    await _newuser();
    await _graphical();
    await _drivers();
    await _aur();
    await _blackarch();
    await _brew();
    await _fish();
    await _swapper();
    if (_variables.xfce) await _xfceTemplate();
    await _optimizations();
    await _finisher();
  }

  Future<void> corelive() async {
    _io.clear();
    await _diskinit(await _diskmenu());
    await _partitioning();
  }
}

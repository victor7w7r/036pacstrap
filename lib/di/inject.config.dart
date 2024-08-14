// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pacstrap/app.dart' as _i523;
import 'package:pacstrap/attach.dart' as _i750;
import 'package:pacstrap/init.dart' as _i423;
import 'package:pacstrap/lang.dart' as _i921;
import 'package:pacstrap/messages.dart' as _i582;
import 'package:pacstrap/pacstrap.dart' as _i338;
import 'package:pacstrap/postchroot/aur.dart' as _i877;
import 'package:pacstrap/postchroot/blackarch.dart' as _i637;
import 'package:pacstrap/postchroot/brew.dart' as _i16;
import 'package:pacstrap/postchroot/configurator.dart' as _i929;
import 'package:pacstrap/postchroot/drivers.dart' as _i747;
import 'package:pacstrap/postchroot/finisher.dart' as _i836;
import 'package:pacstrap/postchroot/fish.dart' as _i267;
import 'package:pacstrap/postchroot/graphical.dart' as _i31;
import 'package:pacstrap/postchroot/hostname_locale.dart' as _i952;
import 'package:pacstrap/postchroot/newuser.dart' as _i274;
import 'package:pacstrap/postchroot/optimizations.dart' as _i629;
import 'package:pacstrap/postchroot/postchroot.dart' as _i944;
import 'package:pacstrap/postchroot/swapper.dart' as _i867;
import 'package:pacstrap/postchroot/xfcetemplate.dart' as _i325;
import 'package:pacstrap/prechroot/diskformat.dart' as _i661;
import 'package:pacstrap/prechroot/diskinit.dart' as _i248;
import 'package:pacstrap/prechroot/diskmenu.dart' as _i671;
import 'package:pacstrap/prechroot/pacstraper.dart' as _i418;
import 'package:pacstrap/prechroot/partitioning.dart' as _i599;
import 'package:pacstrap/prechroot/prechroot.dart' as _i620;
import 'package:pacstrap/prechroot/toggler.dart' as _i944;
import 'package:pacstrap/variables.dart' as _i400;
import 'package:zerothreesix_dart/zerothreesix_dart.dart' as _i717;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i400.Variables>(() => _i400.Variables());
    gh.factory<_i750.Attach>(() => _i750.Attach(gh<_i717.Lang>()));
    gh.factory<_i921.InitLang>(() => _i921.InitLang(gh<_i717.Lang>()));
    gh.factory<_i582.Messages>(() => _i582.Messages(
          gh<_i750.Attach>(),
          gh<_i717.Colorize>(),
          gh<_i717.Lang>(),
        ));
    gh.factory<_i867.Swapper>(() => _i867.Swapper(
          gh<_i338.Attach>(),
          gh<_i717.InputOutput>(),
          gh<_i338.Messages>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i671.DiskMenu>(() => _i671.DiskMenu(
          gh<_i338.Attach>(),
          gh<_i717.Colorize>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
        ));
    gh.factory<_i944.Toggler>(() => _i944.Toggler(
          gh<_i338.Attach>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i952.HostnameLocale>(() => _i952.HostnameLocale(
          gh<_i750.Attach>(),
          gh<_i717.Colorize>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i717.Tui>(),
        ));
    gh.factory<_i836.Finisher>(() => _i836.Finisher(
          gh<_i338.Attach>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i717.Tui>(),
        ));
    gh.factory<_i877.Aur>(() => _i877.Aur(
          gh<_i338.Attach>(),
          gh<_i717.Lang>(),
          gh<_i717.InputOutput>(),
          gh<_i338.Messages>(),
        ));
    gh.factory<_i325.Xfcetemplate>(() => _i325.Xfcetemplate(
          gh<_i338.Attach>(),
          gh<_i717.Colorize>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i248.DiskInit>(() => _i248.DiskInit(
          gh<_i338.Attach>(),
          gh<_i717.Colorize>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i423.Init>(() => _i423.Init(
          gh<_i338.Attach>(),
          gh<_i338.InitLang>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i717.Tui>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i16.Brew>(() => _i16.Brew(
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i629.Optimizations>(() => _i629.Optimizations(
          gh<_i338.Attach>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
        ));
    gh.factory<_i31.Graphical>(() => _i31.Graphical(
          gh<_i338.Attach>(),
          gh<_i717.Colorize>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
          gh<_i717.Tui>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i267.Fish>(() => _i267.Fish(
          gh<_i717.InputOutput>(),
          gh<_i338.Messages>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i929.Configurator>(() => _i929.Configurator(
          gh<_i717.Colorize>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
        ));
    gh.factory<_i418.Pacstraper>(() => _i418.Pacstraper(
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
          gh<_i944.Toggler>(),
        ));
    gh.factory<_i274.Newuser>(() => _i274.Newuser(
          gh<_i338.Attach>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i637.Blackarch>(() => _i637.Blackarch(
          gh<_i338.Attach>(),
          gh<_i717.Colorize>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
        ));
    gh.factory<_i747.Drivers>(() => _i747.Drivers(
          gh<_i338.Attach>(),
          gh<_i717.Colorize>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
        ));
    gh.factory<_i661.Diskformat>(() => _i661.Diskformat(
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Messages>(),
          gh<_i418.Pacstraper>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i599.Partitioning>(() => _i599.Partitioning(
          gh<_i338.Attach>(),
          gh<_i717.Colorize>(),
          gh<_i661.Diskformat>(),
          gh<_i717.InputOutput>(),
          gh<_i717.Lang>(),
          gh<_i338.Variables>(),
        ));
    gh.factory<_i523.App>(() => _i523.App(
          gh<_i944.Aur>(),
          gh<_i944.Blackarch>(),
          gh<_i944.Brew>(),
          gh<_i944.Configurator>(),
          gh<_i944.HostnameLocale>(),
          gh<_i620.DiskInit>(),
          gh<_i620.DiskMenu>(),
          gh<_i944.Drivers>(),
          gh<_i944.Finisher>(),
          gh<_i944.Graphical>(),
          gh<_i944.Fish>(),
          gh<_i717.InputOutput>(),
          gh<_i944.Newuser>(),
          gh<_i944.Optimizations>(),
          gh<_i620.Partitioning>(),
          gh<_i944.Swapper>(),
          gh<_i400.Variables>(),
          gh<_i944.Xfcetemplate>(),
        ));
    return this;
  }
}

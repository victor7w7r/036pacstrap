import 'package:dcli/dcli.dart' show cyan;

import 'package:pacstrap/pacstrap.dart';

Future<void> blackarch() async {

  clear();

  print(cyan(lang(57)));

  if(stdYesNo()) {
    await coderes('cd; curl -O https://blackarch.org/strap.sh');
    await call('chmod +x /root/strap.sh');
    await coderes('/root/strap.sh');
    ok();
  }
}
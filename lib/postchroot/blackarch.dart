import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> blackarch() async {
  clear();

  cyan(lang(42));

  if (stdYesNo()) {
    await coderes('cd; curl -O https://blackarch.org/strap.sh');
    await call('chmod +x /root/strap.sh');
    await coderes('/root/strap.sh');
    okMessage();
  }
}

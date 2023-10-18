import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> fish() async {
  clear();

  header('FISH');

  await coderes('pacman -S cowfortune lolcat thefuck --noconfirm');
  await call("echo 'Frogs.pm' >> /etc/cowfortune/blacklist");
  await call("echo 'DragonAndCow.pm' >> /etc/cowfortune/blacklist");
  await call("echo 'zen-beavis' >> /etc/cowfortune/blacklist");
  await call("echo 'TuxStab.pm' >> /etc/cowfortune/blacklist");
  await call("echo 'Stegosaurus.pm' >> /etc/cowfortune/blacklist");
  await call("echo 'MechAndCow.pm' >> /etc/cowfortune/blacklist");
  await call("echo 'Example.pm' >> /etc/cowfortune/blacklist");
  await call("echo 'jkh' >> /etc/cowfortune/blacklist");
  clear();
  await call("sudo -u $sudouser bash -c 'chsh -s /bin/fish'");
  await call('chsh -s /bin/fish');
  await coderes('git clone https://github.com/victor7w7r/dotfiles /root');
  await call('cp -r /root/dotfiles/fish /root/.config/fish');
  await call('cp -r /root/dotfiles/fish /home/$sudouser/.config/fish');
  await call('chown -R $sudouser:$sudouser /home/$sudouser/.config/fish');

  okMessage();
}

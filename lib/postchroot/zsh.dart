import 'package:pacstrap/pacstrap.dart';

Future<void> zsh() async {

  clear();

  header('OMZ');

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
  await call("sudo -u $sudouser bash -c 'chsh -s /bin/zsh'");
  await call('chsh -s /bin/zsh');
  await coderes('wget https://raw.githubusercontent.com/victor7w7r/036pacstrap/master/zsh.tar.xz '
    '-O /root/zsh.tar.xz'
  );
  await coderes('tar -xf /root/zsh.tar.xz -C /root/');
  await call('cp -r /root/.oh-my-zsh/ /home/$sudouser/');
  await call('cp /root/.zshrc /home/$sudouser/.zshrc');
  await call('chown -R $sudouser:$sudouser /home/$sudouser/.oh-my-zsh');
  await call('chown $sudouser /home/$sudouser/.zshrc');

  ok();

}
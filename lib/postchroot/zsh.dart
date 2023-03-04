import 'dart:io' show stdin;

import 'package:pacstrap/index.dart';

Future<void> zsh() async {

  final sudouser = locator.get<App>().sudouser;

  clear();

  print('=============== OMZ =============== \n');

  await codeproc('pacman -S cowfortune lolcat thefuck --noconfirm');
  await syscall("echo 'Frogs.pm' >> /etc/cowfortune/blacklist");
  await syscall("echo 'DragonAndCow.pm' >> /etc/cowfortune/blacklist");
  await syscall("echo 'zen-beavis' >> /etc/cowfortune/blacklist");
  await syscall("echo 'TuxStab.pm' >> /etc/cowfortune/blacklist");
  await syscall("echo 'Stegosaurus.pm' >> /etc/cowfortune/blacklist");
  await syscall("echo 'MechAndCow.pm' >> /etc/cowfortune/blacklist");
  await syscall("echo 'Example.pm' >> /etc/cowfortune/blacklist");
  await syscall("echo 'jkh' >> /etc/cowfortune/blacklist");
  clear();
  await syscall("sudo -u $sudouser bash -c 'chsh -s /bin/zsh'");
  await syscall('chsh -s /bin/zsh');
  await codeproc('wget https://raw.githubusercontent.com/victor7w7r/036pacstrap/master/zsh.tar.xz -O /root/zsh.tar.xz');
  await codeproc('tar -xf /root/zsh.tar.xz -C /root/');
  await syscall('cp -r /root/.oh-my-zsh/ /home/$sudouser/');
  await syscall('cp /root/.zshrc /home/$sudouser/.zshrc');
  await syscall('chown -R $sudouser:$sudouser /home/$sudouser/.oh-my-zsh');
  await syscall('chown $sudouser /home/$sudouser/.zshrc');


  print('');
  print('=============== OK =============== \n');
  print(lang(45));
  stdin.readLineSync();

}

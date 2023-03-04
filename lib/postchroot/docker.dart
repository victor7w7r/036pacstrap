import 'dart:io' show stdin;

import 'package:dcli/dcli.dart' show cyan;
import 'package:console/console.dart' show Chooser;

import 'package:pacstrap/index.dart';

Future<void> docker() async {

  final sudouser = locator.get<App>().sudouser;

  clear();

  print(cyan(lang(58)));

  final sel = Chooser<String>(locator.get<App>().english ? ['Yes', 'No'] : ['Si', 'No'], message: lang(33)).chooseSync();

  if(sel == 'Yes' || sel == 'Si')  {
    await codeproc('pacman -S docker --noconfirm');
    await syscall('usermod -a -G docker $sudouser');
    await syscall('systemctl enable docker.service');
    await syscall('systemctl start docker.service');
    await codeproc('docker pull portainer/portainer-ce:latest');
    await syscall('docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest');
    print('');
    print('=============== OK =============== \n');
    print(lang(45));
    stdin.readLineSync();
  }

}
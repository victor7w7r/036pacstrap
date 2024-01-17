import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/pacstrap.dart';

Future<void> docker() async {
  clear();

  cyan(lang(58));

  if (stdYesNo()) {
    await coderes('pacman -S docker --noconfirm');
    await call('usermod -a -G docker $sudouser');
    await call('systemctl enable docker.service');
    await call('systemctl start docker.service');
    await coderes('docker pull portainer/portainer-ce:latest');
    await call(
        'docker run -d -p 9000:9000 --name=portainer --restart=always -v '
        '/var/run/docker.sock:/var/run/docker.sock -v '
        'portainer_data:/data portainer/portainer-ce:latest');
    okMessage();
  }
}

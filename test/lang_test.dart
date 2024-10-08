// ignore_for_file: lines_longer_than_80_chars, no_adjacent_strings_in_list

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

import 'package:pacstrap/lang.dart';

final class MockLang extends Mock implements Lang {}

void main() {
  group('InitLang', () {
    late MockLang mockLang;

    late InitLang initLang;

    setUp(() {
      mockLang = MockLang();
      initLang = InitLang(mockLang);
    });

    test('lang', () {
      when(() => mockLang.dictEsp).thenReturn([]);
      when(() => mockLang.dictEng).thenReturn([]);
      when(() => mockLang.dictDialogEng).thenReturn([]);
      when(() => mockLang.dictDialogEsp).thenReturn([]);

      initLang();

      verify(
        () => mockLang.dictEng.addAll([
          'Your Operating System is not GNU/Linux, exiting',
          'You are not superuser, please run as root',
          'This scripts only works in UEFI/EFI systems, consider '
              'change your PC or check your BIOS',
          'This script is only intended to run on x86_64 PCs.',
          "Arch Linux pacman is not available in this system, this system isn't Arch Linux?",
          "This PC doesn't have internet connection, please check",
          'Updating Arch Repositories...',
          'f2fs.tools is not available in this system, installing',
          'whiptail is not available in this system, installing',
          'pacstrap is not available in this system, installing',
          'All dependencies is ok!',
          'There are not available disk devices in your system, exiting',
          'Number: ',
          'Choose your destination device for install\n',
          'This device has a DOS Label Type or is not initialized '
              'Do you want to initialize it with GPT?\n',
          'WARNING!: Your destination device would be formatted and empty\n',
          'Initializing / Creating EFI partition\n\n',
          'Press Enter to continue...',
          'This device is using with other partitions but not have EFI partition, '
              'Do you want to create a EFI partition?\n',
          'There is a EFI partition but is not in the *1 position, '
              'the device must be erased, Do you want to continue?\n',
          'There is not any btrfs or compatible partition to install, '
              'you can partition manually or exit and run again\n',
          'Partition with cgdisk',
          'Partition with parted',
          'Erase all disk',
          'Exit',
          'There are linux partitions available, remember that when you select it, '
              'it will be formatted\n',
          'Remember that when you select a partition or erase the disk, '
              'the action is irreversible\n',
          '=============== FORMAT ROOT FILESYSTEM AND MOUNTING =============== \n',
          '=============== PACSTRAP: INSTALL LINUX BASE AND CORE PACKAGES =============== \n',
          'Something failed inside the chroot, not unmounting filesystems so you can investigate.',
          '=============== ROOT PASSWORD FOR YOUR SYSTEM =============== \n',
          'Choose your processor \n',
          '=============== CONFIGURE GRUB =============== \n',
          '=============== START NETWORKMANAGER AND SSH SERVICES =============== \n',
          'Please write your hostname (ex: A036-arch): ',
          'America/Guayaquil is the timezone by default, if you want to change, '
              'here is the command \n ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime',
          'Choose your locale, if you want to change to other locales, '
              'check the README of the Github of this project\n',
          '=============== ADD A USER TO A SUDO GROUP =============== \n',
          'Write your new user: ',
          'Choose a GUI, these are the common used, this script recommends XFCE\n',
          'Choose your GPU drivers\n',
          '=============== AUR (CHAOTIC-AUR / LIQUORIX KERNEL) ===============  \n',
          'Do you like BlackArch? (Penetration Testing Repository for Arch Linux)\n',
          'You have installed xfce before, do you want to install my template?\n',
          '=============== OPTIMIZATIONS =============== \n',
          'READY!!!, Your PC is succesfully installed with Arch Linux, '
              'if you have errors, please report at 036bootstrap in GitHub',
          'Please reboot and remove your live media',
          '=============== BREW ===============  \n',
        ]),
      ).called(1);

      verify(
        () => mockLang.dictEsp.addAll([
          'Este sistema no es GNU/Linux, saliendo',
          'Tú no eres superusuario, por favor ejecuta como root',
          'Este script sólo trabaja en UEFI/EFI, considera '
              'cambiar tu PC o verifica tu BIOS',
          'Este script sólo se ejecuta en procesadores de x86_64.',
          'Arch Linux pacman no está disponible, ¿Acaso esto no es Arch Linux?',
          'No tienes conexión a internet, por favor revisa e inténtalo de nuevo',
          'Actualizando repositorios de Arch...',
          'f2fs.tools no está disponible, instalando',
          'whiptail is no está disponible, instalando',
          'pacstrap no está disponible, instalando',
          'Todo ok!',
          'No existen dispositivos de disco disponibles en tu sistema, saliendo',
          'Número: ',
          'Seleccione su dispositivo de destino para la instalación\n',
          'Este dispositivo tiene una tabla de tipo DOS o no está inicializado '
              '¿Quieres inicializarlo con GPT?\n',
          '¡ATENCION!: Tu dispositivo de destino será formateado y vaciado\n',
          'Inicializando / Creando partición EFI\n\n',
          'Presione Enter para continuar...',
          'Este dispositivo está usando con otras particiones pero no tiene partición EFI, '
              '¿Quieres crear una partición EFI?\n',
          'Existe una partición EFI pero no es está en la posición *1, el dispositivo se tiene que borrar entero, '
              '¿Quieres continuar?\n',
          'No existe ninguna partición btrfs o compatible con Linux para instalar, '
              'puedes particionar manualmente o salir y volver a ejecutar\n',
          'Particionar con cgdisk',
          'Particionar con parted',
          'Borrar todo el disco',
          'Salir',
          'Existen particiones de linux disponibles, recuerda que al seleccionarlo se va a formatear\n',
          'Recuerda que al seleccionar una partición o borrar el disco al completo, la acción es irreversible\n',
          '=============== FORMATEAR PARTICION DE RAIZ Y MONTADO =============== \n',
          '=============== PACSTRAP: INSTALAR LA BASE DE LINUX Y PAQUETES CORE  =============== \n',
          'Algo falló en el chroot, no se desmontarán los sistemas de archivos, '
              'así que puedes investigar.',
          '=============== CONTRASEÑA DE ROOT PARA EL SISTEMA =============== \n',
          'Selecciona tu procesador \n',
          '=============== CONFIGURAR GRUB =============== \n',
          '=============== INICIAR NETWORKMANAGER Y SERVICIOS DE SSH =============== \n',
          'Por favor escriba su hostname (ej: A036-arch): ',
          'America/Guayaquil es el timezone por defecto, si quieres cambiarlo por '
              'algun otro, aquí está la orden \n'
              'ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime',
          'Elige tu Locale, si quieres cambiar a otros, revisa el README '
              'dentro del GitHub de este proyecto\n',
          '=============== AGREGAR UN USUARIO DE SUDO =============== \n',
          'Escribe tu nuevo usuario: ',
          'Selecciona un GUI, estos son los mas usados, Este script recomienda XFCE\n',
          'Elige tu controlador de GPU\n',
          '=============== AUR (CHAOTIC-AUR / LIQUORIX KERNEL) ===============  \n',
          '¿Te gusta BlackArch? (Repositorio de Penetration Testing para Arch Linux)\n',
          'Has instalado xfce antes, ¿te gustaría instalar mi template?\n',
          '=============== OPTIMIZACIONES =============== \n',
          'LISTO!!!, Tu PC ya instalo de manera correcta a Arch Linux, '
              'si hubo errores, reportalo en 036bootstrap / GitHub',
          'Por favor reinicia y quita tu medio de live',
          '=============== BREW ===============  \n',
        ]),
      ).called(1);
    });
  });
}

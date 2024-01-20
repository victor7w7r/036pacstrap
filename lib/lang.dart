// ignore_for_file: no_adjacent_strings_in_list, lines_longer_than_80_chars
import 'package:zerothreesix_dart/zerothreesix_dart.dart'
    show setDictEng, setDictEsp;

void initLang() {
  setDictEsp([
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
    'No existen dispositivos de disco disponibles en tu sistema, saliendo', //11
    'Número: ',

    'Este dispositivo tiene una tabla de tipo DOS o no está inicializado '
        '¿Quieres inicializarlo con GPT?',
    '¡ATENCION!: Tu dispositivo de destino será formateado y vaciado',
    'Este dispositivo no tiene una partición EFI',
    'Este dispositivo tiene una tabla de tipo DOS (MBR), '
        'este script sólo trabaja con GPT',
    'Elegiste como SSD, pero este dispositivo es rotacional, '
        'si no es el caso, entonces este dispositivo es USB',
    'Elegiste como HDD, pero este dispositivo no es rotational, '
        'por favor verifica y ejecuta este script otra vez',
    'Este dispositivo no tiene una partición EFI',
    'Este dispositivo tiene una partición EFI en otro lado que no sea *1',
    'No hay discos disponibles en tu sistema, por favor verifica!!!',
    '=============== FORMATEAR PARTICIONES DE RAIZ E INTERCAMBIO =============== \n',
    '=============== FORMATEAR PARTICION DE RAIZ =============== \n',
    '=============== FORMATEAR EFI Y MONTARLO =============== \n',
    'Particiones desmontadas de manera exitosa',
    '=============== PACSTRAP: INSTALAR LA BASE DE LINUX Y PAQUETES CORE  =============== \n',
    'Algo falló en el chroot, no se desmontarán los sistemas de archivos, '
        'así que puedes investigar.',
    'Por favor desmonta tus particiones y reinicia este script',
    '=============== CONTRASEÑA DE ROOT PARA EL SISTEMA =============== \n',
    '=============== CONFIGURAR GRUB =============== \n',
    '=============== INICIAR NETWORKMANAGER Y SERVICIOS DE SSH =============== \n',
    '=============== AGREGAR UN USUARIO DE SUDO =============== \n',
    '=============== AUR (CHAOTIC-AUR / LIQUORIX KERNEL) ===============  \n',
    'Hemos creado un script llamado omz.sh en tu carpeta de home, '
        'después de reiniciar, usa chmod +x omz.sh',
    '=============== OPTIMIZACIONES =============== \n',
    'Hemos creado un script llamado software.sh en tu carpeta de home, '
        'después de reiniciar, usa chmod +x software.sh',
    'Número: ',
    'Por favor reinicia y quita tu medio de live',
    'Seleccione su tipo de disco para la instalacion\n',
    'CUIDADO!!!: Tu dispositivo debe estar vacio y formateado, '
        'formatear siempre mata tus datos, POR FAVOR haz una copia antes de continuar',
    'Antes de instalar, se recomienda que tu disco tenga esta tabla de particiones\n',
    'GNU Parted script, es un ejemplo para un disco de 20G',
    'Elige un dispositivo para instalar\n',
    'Por favor seleccione su partición de raiz\n',
    'Por favor seleccione una swap partition\n',
    'Estas particiones se van a formatear',
    'Presione Enter para continuar...',
    'Por favor escriba su hostname (ej: A036-arch): ',
    'America/Guayaquil es el timezone por defecto, si quieres cambiarlo por '
        'algun otro, aquí está la orden \n'
        'ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime',
    'Elige tu Locale, si quieres cambiar a otros, revisa el README '
        'dentro del GitHub de este proyecto\n',
    'Escribe tu nuevo usuario: ',
    'Selecciona un GUI, estos son los mas usados, Este script recomienda XFCE\n',
    'Elige tu controlador de GPU\n',
    'Si ejecutas como invitado',
    'Mas Sofware!!',
    'Este script tiene un pequeno pack de software, ¿Te gusta',
    'LISTO!!!, Tu PC ya instalo de manera correcta a Arch Linux, '
        'si hubo errores, reportalo en 036bootstrap / GitHub',
    'Elige tu procesador',
    '¿Te gusta BlackArch? (Repositorio de Penetration Testing para Arch Linux)\n',
    '¿Y docker? (Docker es una herramienta de contenedores para Linux)\n',
    'Has instalado xfce antes, ¿te gustaría instalar mi template?\n',
    '¿Te gustaría instalar esto?',
    'Instalando un entorno de escritorio, hay un servicio que rompe el sistema, '
        'esto se arreglará eventualmente, de momento, usa XORG',
    'Selecciona tu marca de procesador',
  ]);
  setDictEng([
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
    'There are not available disk devices in your system, exiting', //11

    'This device has a DOS Label Type or is not initialized '
        'Do you want to initialize it with GPT?',
    'WARNING!: Your destination device would be formatted and empty',
    'The device has a DOS Label Type (MBR), this script only works with GPT',
    'You choose a SSD device, but this device is rotational, '
        'if is that not the case, that device is USB',
    'You choose a HDD device, but this device is not rotational, '
        'please check and run this script again',
    "The device doesn't have a EFI partition",
    'The device has the EFI partition in other side than *1',
    'All the partitions of the device are mounted in your system, '
        'please unmount the desired partition',
    '=============== FORMAT ROOT FILESYSTEM AND SWAP =============== \n',
    '=============== FORMAT ROOT FILESYSTEM =============== \n',
    '=============== FORMAT EFI AND MOUNT =============== \n',
    'unmounted filesystems succesfully',
    '=============== PACSTRAP: INSTALL LINUX BASE AND CORE PACKAGES =============== \n',
    'Something failed inside the chroot, not unmounting filesystems so you can investigate.',
    'Please umount all partitions, and restart this script',
    '=============== ROOT PASSWORD FOR YOUR SYSTEM =============== \n',
    '=============== CONFIGURE GRUB =============== \n',
    '=============== START NETWORKMANAGER AND SSH SERVICES =============== \n',
    '=============== ADD A USER TO A SUDO GROUP =============== \n',
    '=============== AUR (CHAOTIC-AUR / LIQUORIX KERNEL) ===============  \n',
    'We create a script called omz.sh in your home directory, '
        'after reboot, use chmod +x at omz.sh',
    '=============== OPTIMIZATIONS =============== \n',
    'We create a script called software.sh in your home directory, '
        'after reboot, use chmod +x at software.sh',
    'Number: ',
    'Please reboot and remove your live media',
    'Please choose your disk type\n',
    'DANGER!!!: Your destination device would be formatted and empty, '
        'formatting always cause data loss, PLEASE backup all your data before start',
    'Before installing, we recomend that your disk has the next partition scheme\n',
    'GNU Parted script example for format a 20GB disk',
    'Choose a device for install\n',
    'Please select a root partition\n',
    'Please select a swap partition\n',
    'This partitions will be format',
    'Press Enter to continue...',
    'Please write your hostname (ex: A036-arch): ',
    'America/Guayaquil is the timezone by default, if you want to change, '
        'here is the command \n ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime',
    'Choose your locale, if you want to change to other locales, '
        'check the README of the Github of this project\n',
    'Write your new user: ',
    'Choose a GUI, these are the common used, this script recommends XFCE\n',
    'Choose your GPU drivers\n',
    'If you are executing Arch Linux as a guest',
    'More Sofware!!',
    'This script has a little pack of software, Do you like it',
    'READY!!!, Your PC is succesfully installed with Arch Linux, '
        'if you have errors, please report at 036bootstrap in GitHub',
    'Choose your procesor',
    'Do you like BlackArch? (Penetration Testing Repository for Arch Linux)\n',
    'And Docker? (Docker is a containerization tool for Linux)\n',
    'You have installed xfce before, do you want to install my template?\n',
    'Do you like to install this?',
    'Installing any Desktop Env, dev service breaks your system, '
        'this bug will be fixed later, i recommend to use XORG ONLY',
    'Select your processor brand',
  ]);
}

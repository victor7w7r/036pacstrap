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
    'No existen dispositivos de disco disponibles en tu sistema, saliendo',
    'Número: ', //13
    'Seleccione su dispositivo de destino para la instalación\n',
    'Este dispositivo tiene una tabla de tipo DOS o no está inicializado '
        '¿Quieres inicializarlo con GPT?',
    '¡ATENCION!: Tu dispositivo de destino será formateado y vaciado',
    'Creando partición EFI',
    'Este dispositivo está usando con otras particiones pero no tiene partición EFI, '
        '¿Quieres crear una partición EFI?',
    'Existe una partición EFI pero no es está en la posición *1, el dispositivo se tiene que borrar entero, '
        '¿Quieres continuar?', //18
    'No existe ninguna partición ext4 o compatible con Linux para instalar, '
        'puedes particionar manualmente o salir y volver a ejecutar',
    'Particionar con cgdisk',
    'Particionar con parted',
    'Borrar todo el disco',
    'Salir',
    'Existen particiones de linux disponibles, recuerda que al seleccionarlo se va a formatear',
    'Recuerda que al seleccionar una partición o borra el disco al completo, la acción es irreversible',
    '=============== FORMATEAR PARTICION DE RAIZ Y MONTADO =============== \n', //26
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
    'There are not available disk devices in your system, exiting',
    'Number: ', //13
    'Choose your destination device for install\n',
    'This device has a DOS Label Type or is not initialized '
        'Do you want to initialize it with GPT?',
    'WARNING!: Your destination device would be formatted and empty',
    'Creating EFI partition',
    'This device is using with other partitions but not have EFI partition, '
        'Do you want to create a EFI partition?',
    'There is a EFI partition but is not in the *1 position, '
        'the device must be erased, Do you want to continue?',
    'There is not any ext4 or compatible partition to install, '
        'you can partition manually or exit and run again',
    'Partition with cgdisk',
    'Partition with parted',
    'Erase all disk',
    'Exit',
    'There are linux partitions available, remember that when you select it, '
        'it will be formatted',
    'Remember that when you select a partition or erase the disk, '
        'the action is irreversible',
    '=============== FORMAT ROOT FILESYSTEM AND MOUNTING =============== \n',
    '=============== PACSTRAP: INSTALL LINUX BASE AND CORE PACKAGES =============== \n',
    'Something failed inside the chroot, not unmounting filesystems so you can investigate.', //28
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

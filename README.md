# 036pacstrap

Bootstrap App for Arch Linux

![Alt text](brandwhite.png?raw=true "Title")

- :bulb: **Features**
  - [Liquorix Kernel](https://liquorix.net/): Best kernel for x86_64
  - [yay](https://github.com/Jguer/yay): AUR Helper (Only Arch Linux)
  - [Fish, OhMyFish](https://github.com/oh-my-fish/oh-my-fish): FISH Shell and Plugins
  - XFCE, GNOME, KDE menu options for install
  - You can install has a VMware Guest
  - INTEL, NVIDIA, ATI, AMD menu options for install
  - Blackarch Repository
  - Some Optimizations

- :warning: **Only Works in x86_64 Processors, UEFI Systems and GPT Disks**
  - MBR systems is not compatible here

- :warning: **This use f2fs filesystem for SSD/NVMe devices**
  - Is the best filesystem for Linux and friendly for NAND like devices

## Prerequisites of use

- Medium understanding of GNU/Linux
- For reading the code, understanding of Dart

## Run, Run?, Run!

- :warning: **Only Works in Arch Linux Based Systems**
  - Other GNU/Linux systems may not work

- :heavy_check_mark: **Use in Arch Linux Live CD, Arch Linux installed systems or Manjaro**

If you are use Arch Linux Live CD you must update the repositories and install git, like this (run as root) and choose your flavour

```bash
pacman -Sy wget
wget https://github.com/victor7w7r/036pacstrap/releases/download/1.0.0/036pacstrap
chmod +x 036pacstrap
./036pacstrap
```

If you need to change to another timezone, use this order

- `ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime`

If you need to change to another locales, use this changes below, if you want more commands, please visit [Arch Linux Guide](https://wiki.archlinux.org/title/installation_guide)

```bash
#edit /etc/locale.gen
vi /etc/locale.gen
#unmark your desired locale
#Save that file and use
locale-gen
```

## Debug and Compile

- Install your sdks

```bash
$ pacman -S dart #Archlinux
$ brew -S dart-sdk #macOS
```

- Initialize the packages

```bash
# Dart
$ cd 036pacstrap
$ dart pub get
```

- Run the app

```bash
# Dart
$ cd 036pacstrap/bin
$ dart pacstrap.dart
```

- And compile your app

```bash
# Dart
$ cd 036pacstrap/bin
$ dart compile exe pacstrap.dart -o 036pacstrap
```

## Development Suite

- Editor: [vscode](https://code.visualstudio.com/)
- Lint and Syntax Check: [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
- Operating Systems for tests: [Arch Linux](https://archlinux.org/)

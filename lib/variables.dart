import 'package:injectable/injectable.dart' show singleton;

@singleton
class Variables {
  String disk = '';
  String diskenvdev = '';
  String efipart = '';
  String rootpart = '';
  String sudouser = '';
  String swappart = '';
  bool xfce = false;
}

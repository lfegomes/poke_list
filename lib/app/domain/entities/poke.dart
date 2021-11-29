import '../../../core/utils/constants.dart';

class Poke {
  final String? name;
  final String? url;
  final String? id;
  var favorite = false;

  Poke({
    this.name,
    this.url,
    this.id,
  });

  getAddress() => '${Constant.AVATAR}$id.png';
}

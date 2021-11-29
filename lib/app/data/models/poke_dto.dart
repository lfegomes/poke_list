import '../../domain/entities/poke.dart';

class PokeDTO extends Poke {
  final String? name;
  final String? url;

  PokeDTO({
    this.name,
    this.url,
  });

  PokeDTO.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

extension PokePageMapper on PokeDTO {
  Poke toEntity() {
    return Poke(
      name: name,
      url: url,
      id: url?.split("/")[6],
    );
  }
}

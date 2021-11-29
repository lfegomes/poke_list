import '../../domain/entities/items.dart';

class ItemDTO extends Item {
  final String? name;
  final String? url;

  ItemDTO({
    this.name,
    this.url,
  });

  ItemDTO.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

extension PokePageMapper on ItemDTO {
  Item toEntity() {
    return Item(
      name: name,
      url: url,
    );
  }
}

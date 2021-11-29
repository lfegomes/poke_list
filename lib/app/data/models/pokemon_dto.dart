import 'package:poke_list/app/domain/entities/pokemon.dart';

class PokemonDTO extends Pokemon {
  final List<Abilities>? abilities;
  final int? id;
  final String name;
  final Sprites? sprites;
  final List<Types>? types;

  PokemonDTO({
    this.abilities,
    this.id,
    this.name = '',
    this.sprites,
    this.types,
  });

  PokemonDTO.fromJson(Map<String, dynamic> json)
      : abilities = (json['abilities'] as List?)
            ?.map((dynamic e) => Abilities.fromJson(e as Map<String, dynamic>))
            .toList(),
        id = json['id'] as int?,
        name = json['name'] as String,
        sprites = (json['sprites'] as Map<String, dynamic>?) != null
            ? Sprites.fromJson(json['sprites'] as Map<String, dynamic>)
            : null,
        types = (json['types'] as List?)
            ?.map((dynamic e) => Types.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'abilities': abilities?.map((e) => e.toJson()).toList(),
        'id': id,
        'name': name,
        'sprites': sprites?.toJson(),
        'types': types?.map((e) => e.toJson()).toList()
      };
}

extension PokemonMapper on PokemonDTO {
  Pokemon toEntity() {
    return Pokemon(
      id: id,
      name: name,
      image: sprites!.frontDefault ?? '',
      ability: abilities![0].ability!.name ?? '',
      type: types![0].type!.name ?? '',
    );
  }
}

class Abilities {
  final Ability? ability;
  final bool? isHidden;
  final int? slot;

  Abilities({
    this.ability,
    this.isHidden,
    this.slot,
  });

  Abilities.fromJson(Map<String, dynamic> json)
      : ability = (json['ability'] as Map<String, dynamic>?) != null
            ? Ability.fromJson(json['ability'] as Map<String, dynamic>)
            : null,
        isHidden = json['is_hidden'] as bool?,
        slot = json['slot'] as int?;

  Map<String, dynamic> toJson() =>
      {'ability': ability?.toJson(), 'is_hidden': isHidden, 'slot': slot};
}

class Ability {
  final String? name;
  final String? url;

  Ability({
    this.name,
    this.url,
  });

  Ability.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

class Sprites {
  final String? frontDefault;

  Sprites({
    this.frontDefault,
  });

  Sprites.fromJson(Map<String, dynamic> json)
      : frontDefault = json['front_default'] as String?;

  Map<String, dynamic> toJson() => {'front_default': frontDefault};
}

class Types {
  final int? slot;
  final Type? type;

  Types({
    this.slot,
    this.type,
  });

  Types.fromJson(Map<String, dynamic> json)
      : slot = json['slot'] as int?,
        type = (json['type'] as Map<String, dynamic>?) != null
            ? Type.fromJson(json['type'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'slot': slot, 'type': type?.toJson()};
}

class Type {
  final String? name;
  final String? url;

  Type({
    this.name,
    this.url,
  });

  Type.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

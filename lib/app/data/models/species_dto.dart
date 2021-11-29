import '../../domain/entities/species.dart';

class SpeciesDTO extends Species {
  final List<EggGroups>? eggGroups;
  final List<FlavorTextEntries>? flavorTextEntries;

  SpeciesDTO({
    this.eggGroups,
    this.flavorTextEntries,
  });

  SpeciesDTO.fromJson(Map<String, dynamic> json)
      : eggGroups = (json['egg_groups'] as List?)
            ?.map((dynamic e) => EggGroups.fromJson(e as Map<String, dynamic>))
            .toList(),
        flavorTextEntries = (json['flavor_text_entries'] as List?)
            ?.map((dynamic e) =>
                FlavorTextEntries.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'egg_groups': eggGroups?.map((e) => e.toJson()).toList(),
        'flavor_text_entries':
            flavorTextEntries?.map((e) => e.toJson()).toList(),
      };
}

extension SpeciesMapper on SpeciesDTO {
  Species toEntity() {
    return Species(
      description: flavorTextEntries![0].flavorText ?? '',
      category: eggGroups![0].name ?? '',
    );
  }
}

class EggGroups {
  final String? name;
  final String? url;

  EggGroups({
    this.name,
    this.url,
  });

  EggGroups.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

class FlavorTextEntries {
  final String? flavorText;
  final Language? language;
  final Version? version;

  FlavorTextEntries({
    this.flavorText,
    this.language,
    this.version,
  });

  FlavorTextEntries.fromJson(Map<String, dynamic> json)
      : flavorText = json['flavor_text'] as String?,
        language = (json['language'] as Map<String, dynamic>?) != null
            ? Language.fromJson(json['language'] as Map<String, dynamic>)
            : null,
        version = (json['version'] as Map<String, dynamic>?) != null
            ? Version.fromJson(json['version'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'flavor_text': flavorText,
        'language': language?.toJson(),
        'version': version?.toJson()
      };
}

class Language {
  final String? name;
  final String? url;

  Language({
    this.name,
    this.url,
  });

  Language.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

class Version {
  final String? name;
  final String? url;

  Version({
    this.name,
    this.url,
  });

  Version.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

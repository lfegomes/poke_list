class Pokemon {
  final int? id;
  final String name;
  final String image;
  final String ability;
  final String type;
  String description = '';
  String category = '';

  Pokemon({
    this.id,
    this.name = '',
    this.image = '',
    this.ability = '',
    this.type = '',
  });
}

import '../entities/items.dart';
import '../entities/poke_page.dart';
import '../entities/pokemon.dart';
import '../entities/species.dart';

abstract class IPokeRepo {
  Future<PokePage> getPokeData({required int offset});
  Future<Pokemon> getPokemonDetail({required String id});
  Future<Species> getSpeciesData({required String id});
  Future<List<Item>> getTypes();
  Future<List<Item>> getCategories();
  Future<List<Item>> getAbilities();
}

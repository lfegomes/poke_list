import '../../domain/entities/items.dart';
import '../../domain/entities/poke_page.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/species.dart';
import '../../domain/interfaces/poke_interface.dart';
import '../models/items_dto.dart';
import '../models/poke_page_dto.dart';
import '../models/pokemon_dto.dart';
import '../models/species_dto.dart';
import '../services/poke_service.dart';

class PokeRepo implements IPokeRepo {
  final PokeService _pokeService;

  PokeRepo(this._pokeService);

  @override
  Future<PokePage> getPokeData({required int offset}) async {
    var response = await _pokeService.pokeListing(offset);
    var responseTwo = response.toEntity();
    return responseTwo;
  }

  @override
  Future<Pokemon> getPokemonDetail({required String id}) async {
    var response = await _pokeService.pokemonDetail(id);
    var responseTwo = response.toEntity();
    return responseTwo;
  }

  @override
  Future<Species> getSpeciesData({required String id}) async {
    var response = await _pokeService.speciesData(id);
    var responseTwo = response.toEntity();
    return responseTwo;
  }

  @override
  Future<List<Item>> getTypes() async {
    var response = await _pokeService.getTypes();
    for (var element in response) {
      element.toEntity();
    }
    return response;
  }

  @override
  Future<List<Item>> getCategories() async {
    var response = await _pokeService.getCategories();
    for (var element in response) {
      element.toEntity();
    }
    return response;
  }

  @override
  Future<List<Item>> getAbilities() async {
    var response = await _pokeService.getAbilities();
    for (var element in response) {
      element.toEntity();
    }
    return response;
  }
}

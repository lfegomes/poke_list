import '../../../core/utils/constants.dart';
import '../entities/items.dart';
import '../entities/poke_page.dart';
import '../entities/pokemon.dart';
import '../entities/species.dart';
import '../interfaces/poke_interface.dart';

class PokeUseCase {
  final IPokeRepo repository;

  PokeUseCase(this.repository);

  Future<PokePage> getPokePage(int page) async {
    var limit = Constant.ITEMS_PER_PAGE;
    int offset = (page - 1) * limit;
    var response = await repository.getPokeData(offset: offset);
    var total = response.count!;
    var last = offset + limit;
    if (total > last) {
      response.nextPage = true;
    }
    return response;
  }

  Future<Pokemon> getPokemonDetail(String id) async {
    var response = await repository.getPokemonDetail(id: id);
    return response;
  }

  Future<Species> getSpeciesData(String id) async {
    var response = await repository.getSpeciesData(id: id);
    return response;
  }

  Future<List<Item>> getTypes() async {
    var response = await repository.getTypes();
    return response;
  }

  Future<List<Item>> getCategories() async {
    var response = await repository.getCategories();
    return response;
  }

  Future<List<Item>> getAbilities() async {
    var response = await repository.getAbilities();
    return response;
  }
}

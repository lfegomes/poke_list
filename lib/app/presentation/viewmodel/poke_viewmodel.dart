import 'package:mobx/mobx.dart';
import 'package:poke_list/core/utils/constants.dart';
import '../../domain/entities/items.dart';
import '../../domain/entities/species.dart';

import '../../domain/entities/poke.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/use_case/poke_usecase.dart';

part 'poke_viewmodel.g.dart';

class PokeViewModel = _PokeViewModelBase with _$PokeViewModel;

abstract class _PokeViewModelBase with Store {
  PokeUseCase uc;
  _PokeViewModelBase(this.uc);

  /// Page controller
  @observable
  int currentPage = 0;

  @action
  void setCurrentPage(int value) => currentPage = value;

  /// Pokemon Listing
  var nextPage = 1;
  var newPageItems = <Poke>[];
  var pokeList = <Poke>[];

  @observable
  int somethingWentWrong = 0;

  @observable
  int appendPoke = 0;

  @action
  Future<void> fetchPoke(int page) async {
    try {
      if (page == 1 && pokeList.length >= Constant.ITEMS_PER_PAGE) {
        newPageItems = pokeList;
      } else {
        var pokePage = await uc.getPokePage(page);
        if (pokePage.nextPage == true) {
          nextPage++;
        } else {
          nextPage = 0;
        }
        total = pokePage.count!;
        newId = total! + 1;
        if (page == 1) {
          newPageItems = newPokeList;
          newPageItems.addAll(pokePage.results!);
        } else {
          newPageItems = pokePage.results!;
        }

        updatePokeList(pokePage.results!);
      }
      appendPoke++;
    } catch (e) {
      somethingWentWrong++;
    }
  }

  void updatePokeList(List<Poke> list) {
    pokeList.addAll(list);
  }

  /// Favorites
  var favorites = <Poke>[];

  @observable
  var showFavorites = false;

  @action
  void toggleFavorites() {
    if (showFavorites == false) {
      updateFavoritePokeList();
    }
    showFavorites = !showFavorites;
  }

  @action
  void updateFavoritePokeList() {
    final checking = pokeList.where(
      (poke) {
        return poke.favorite == true;
      },
    );
    favorites
      ..clear()
      ..addAll(checking);
  }

  /// Pokemon Detail
  @observable
  var loadingDetail = false;

  @observable
  var detailError = false;

  Pokemon pokemonDetail = Pokemon();
  Species speciesData = Species();

  @action
  Future<void> fetchPokemon(String id) async {
    var intId = int.parse(id);
    if (intId > total!) {
      var index = intId - total!;
      pokemonDetail = newPokemonsList[index - 1];
    } else {
      try {
        detailError = false;
        loadingDetail = true;
        pokemonDetail = await uc.getPokemonDetail(id);
        speciesData = await uc.getSpeciesData(id);
        pokemonDetail.description =
            speciesData.description.replaceAll("\n", " ");
        pokemonDetail.category = speciesData.category;
        loadingDetail = false;
      } catch (e) {
        loadingDetail = false;
        detailError = true;
      }
    }
  }

  /// Pokemon Register
  String? name;
  String? category;
  String? type;
  String? ability;
  String? description;
  String? imagePath;

  int? total;
  int? newId;

  var newPokemonsList = <Pokemon>[];
  var newPokeList = <Poke>[];

  void saveNewPokemon() {
    newId = newId ?? 1119;
    var newPokemon = Pokemon(
      id: newId,
      name: name!,
      ability: ability!,
      type: type!,
      image: imagePath!,
    );
    newPokemon.category = category!;
    newPokemon.description = description!;
    var newPoke = Poke(
      id: newId.toString(),
      name: name!,
      url: imagePath!,
    );
    newId = newId! + 1;
    newPokemonsList.add(newPokemon);
    newPokeList.add(newPoke);
    pokeList.insert(0, newPoke);
  }

  @observable
  var loadingItems = false;

  @observable
  var itemsError = false;

  var abilities = ObservableList<Item>();
  var categories = ObservableList<Item>();
  var types = ObservableList<Item>();

  @action
  Future<void> fetchItems() async {
    try {
      itemsError = false;
      loadingItems = true;
      abilities = (await uc.getAbilities()).asObservable();
      categories = (await uc.getCategories()).asObservable();
      types = (await uc.getTypes()).asObservable();
      loadingItems = false;
    } catch (e) {
      loadingItems = false;
      itemsError = true;
    }
  }
}

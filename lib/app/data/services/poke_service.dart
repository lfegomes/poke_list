import 'package:dio/dio.dart';

import '../../../core/core_packages.dart';
import '../../../core/utils/constants.dart';
import '../models/items_dto.dart';
import '../models/poke_page_dto.dart';
import '../models/pokemon_dto.dart';
import '../models/species_dto.dart';

class PokeService {
  final _httpService = GetIt.I<HttpService>();

  Future<PokePageDTO> pokeListing(int offset) async {
    var limit = Constant.ITEMS_PER_PAGE;
    try {
      Response response = await _httpService.get(
        "pokemon?offset=$offset&limit=$limit",
      );
      return PokePageDTO.fromJson(
        response.data,
      );
      // await Future.delayed(Duration(seconds: 1));
      // return Future.error('error');
    } catch (error) {
      throw error;
    }
  }

  Future<PokemonDTO> pokemonDetail(String id) async {
    try {
      Response response = await _httpService.get(
        "pokemon/$id",
      );
      return PokemonDTO.fromJson(
        response.data,
      );
    } catch (error) {
      throw error;
    }
  }

  Future<SpeciesDTO> speciesData(String id) async {
    try {
      Response response = await _httpService.get(
        "pokemon-species/$id",
      );
      return SpeciesDTO.fromJson(
        response.data,
      );
    } catch (error) {
      throw error;
    }
  }

  Future<List<ItemDTO>> getTypes() async {
    try {
      Response response = await _httpService.get(
        "type",
      );
      return response.data['results']
          .map<ItemDTO>((data) => ItemDTO.fromJson(data))
          .toList();
    } catch (error) {
      throw error;
    }
  }

  Future<List<ItemDTO>> getCategories() async {
    try {
      Response response = await _httpService.get(
        "egg-group",
      );
      return response.data['results']
          .map<ItemDTO>((data) => ItemDTO.fromJson(data))
          .toList();
    } catch (error) {
      throw error;
    }
  }

  Future<List<ItemDTO>> getAbilities() async {
    try {
      Response response = await _httpService.get(
        "ability",
      );
      return response.data['results']
          .map<ItemDTO>((data) => ItemDTO.fromJson(data))
          .toList();
    } catch (error) {
      throw error;
    }
  }
}

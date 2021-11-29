import '../../domain/entities/poke_page.dart';
import 'poke_dto.dart';

class PokePageDTO extends PokePage {
  final int? count;
  final String? next;
  final String? previous;
  final List<PokeDTO>? results;

  PokePageDTO({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  PokePageDTO.fromJson(Map<String, dynamic> json)
      : count = json['count'] as int?,
        next = json['next'] as String?,
        previous = json['previous'] as String?,
        results = (json['results'] as List?)
            ?.map((dynamic e) => PokeDTO.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results?.map((e) => e.toJson()).toList()
      };
}

extension PokePageMapper on PokePageDTO {
  PokePage toEntity() {
    return PokePage(
      count: count,
      next: next,
      previous: previous,
      results: results?.map((e) => e.toEntity()).toList(),
    );
  }
}

import 'poke.dart';

class PokePage {
  bool nextPage = false;
  final int? count;
  final String? next;
  final String? previous;
  final List<Poke>? results;

  PokePage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
}

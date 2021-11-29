// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poke_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeViewModel on _PokeViewModelBase, Store {
  final _$currentPageAtom = Atom(name: '_PokeViewModelBase.currentPage');

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  final _$somethingWentWrongAtom =
      Atom(name: '_PokeViewModelBase.somethingWentWrong');

  @override
  int get somethingWentWrong {
    _$somethingWentWrongAtom.reportRead();
    return super.somethingWentWrong;
  }

  @override
  set somethingWentWrong(int value) {
    _$somethingWentWrongAtom.reportWrite(value, super.somethingWentWrong, () {
      super.somethingWentWrong = value;
    });
  }

  final _$appendPokeAtom = Atom(name: '_PokeViewModelBase.appendPoke');

  @override
  int get appendPoke {
    _$appendPokeAtom.reportRead();
    return super.appendPoke;
  }

  @override
  set appendPoke(int value) {
    _$appendPokeAtom.reportWrite(value, super.appendPoke, () {
      super.appendPoke = value;
    });
  }

  final _$showFavoritesAtom = Atom(name: '_PokeViewModelBase.showFavorites');

  @override
  bool get showFavorites {
    _$showFavoritesAtom.reportRead();
    return super.showFavorites;
  }

  @override
  set showFavorites(bool value) {
    _$showFavoritesAtom.reportWrite(value, super.showFavorites, () {
      super.showFavorites = value;
    });
  }

  final _$loadingDetailAtom = Atom(name: '_PokeViewModelBase.loadingDetail');

  @override
  bool get loadingDetail {
    _$loadingDetailAtom.reportRead();
    return super.loadingDetail;
  }

  @override
  set loadingDetail(bool value) {
    _$loadingDetailAtom.reportWrite(value, super.loadingDetail, () {
      super.loadingDetail = value;
    });
  }

  final _$detailErrorAtom = Atom(name: '_PokeViewModelBase.detailError');

  @override
  bool get detailError {
    _$detailErrorAtom.reportRead();
    return super.detailError;
  }

  @override
  set detailError(bool value) {
    _$detailErrorAtom.reportWrite(value, super.detailError, () {
      super.detailError = value;
    });
  }

  final _$loadingItemsAtom = Atom(name: '_PokeViewModelBase.loadingItems');

  @override
  bool get loadingItems {
    _$loadingItemsAtom.reportRead();
    return super.loadingItems;
  }

  @override
  set loadingItems(bool value) {
    _$loadingItemsAtom.reportWrite(value, super.loadingItems, () {
      super.loadingItems = value;
    });
  }

  final _$itemsErrorAtom = Atom(name: '_PokeViewModelBase.itemsError');

  @override
  bool get itemsError {
    _$itemsErrorAtom.reportRead();
    return super.itemsError;
  }

  @override
  set itemsError(bool value) {
    _$itemsErrorAtom.reportWrite(value, super.itemsError, () {
      super.itemsError = value;
    });
  }

  final _$fetchPokeAsyncAction = AsyncAction('_PokeViewModelBase.fetchPoke');

  @override
  Future<void> fetchPoke(int page) {
    return _$fetchPokeAsyncAction.run(() => super.fetchPoke(page));
  }

  final _$fetchPokemonAsyncAction =
      AsyncAction('_PokeViewModelBase.fetchPokemon');

  @override
  Future<void> fetchPokemon(String id) {
    return _$fetchPokemonAsyncAction.run(() => super.fetchPokemon(id));
  }

  final _$fetchItemsAsyncAction = AsyncAction('_PokeViewModelBase.fetchItems');

  @override
  Future<void> fetchItems() {
    return _$fetchItemsAsyncAction.run(() => super.fetchItems());
  }

  final _$_PokeViewModelBaseActionController =
      ActionController(name: '_PokeViewModelBase');

  @override
  void setCurrentPage(int value) {
    final _$actionInfo = _$_PokeViewModelBaseActionController.startAction(
        name: '_PokeViewModelBase.setCurrentPage');
    try {
      return super.setCurrentPage(value);
    } finally {
      _$_PokeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFavorites() {
    final _$actionInfo = _$_PokeViewModelBaseActionController.startAction(
        name: '_PokeViewModelBase.toggleFavorites');
    try {
      return super.toggleFavorites();
    } finally {
      _$_PokeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateFavoritePokeList() {
    final _$actionInfo = _$_PokeViewModelBaseActionController.startAction(
        name: '_PokeViewModelBase.updateFavoritePokeList');
    try {
      return super.updateFavoritePokeList();
    } finally {
      _$_PokeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
somethingWentWrong: ${somethingWentWrong},
appendPoke: ${appendPoke},
showFavorites: ${showFavorites},
loadingDetail: ${loadingDetail},
detailError: ${detailError},
loadingItems: ${loadingItems},
itemsError: ${itemsError}
    ''';
  }
}

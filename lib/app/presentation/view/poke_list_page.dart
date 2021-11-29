import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';

import '../../../core/core_packages.dart';
import '../../domain/entities/poke.dart';
import '../components/error_screen.dart';
import '../components/loading_indicator.dart';
import '../components/tiny_error.dart';
import '../components/tiny_loading.dart';
import '../viewmodel/poke_viewmodel.dart';

class PokeListPage extends StatefulWidget {
  const PokeListPage({Key? key}) : super(key: key);

  @override
  _PokeListPageState createState() => _PokeListPageState();
}

class _PokeListPageState extends State<PokeListPage> {
  final _vm = GetIt.I<PokeViewModel>();
  final _pagingController = PagingController<int, Poke>(
    firstPageKey: 1,
  );

  List<ReactionDisposer>? _disposers;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((page) {
      Future.delayed(Duration.zero).then((_) {
        _vm.fetchPoke(page);
      });
    });
  }

  @override
  void didChangeDependencies() {
    _disposers ??= [
      reaction(
        (_) => _vm.somethingWentWrong,
        (_) => _pagingController.error = 'error',
      ),
      reaction(
        (_) => _vm.appendPoke,
        (_) {
          if (_vm.nextPage == 0) {
            _pagingController.appendLastPage(_vm.newPageItems);
          } else {
            _pagingController.appendPage(
              _vm.newPageItems,
              _vm.nextPage,
            );
          }
        },
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _disposers!.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KColors.main,
        title: const Text(
          'POKELISTA',
          style: KTextStyle.appBar,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => _vm.setCurrentPage(0),
        ),
        actions: [
          Observer(
            builder: (_) {
              return IconButton(
                icon: Icon(_vm.showFavorites ? Icons.star : Icons.star_border),
                onPressed: () => _vm.toggleFavorites(),
              );
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          return _vm.showFavorites
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 4.0),
                  itemCount: _vm.favorites.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = _vm.favorites[index];
                    return _PokemonCard(
                        poke: item, onTap: () => callModal(item));
                  },
                )
              : RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => _pagingController.refresh(),
                  ),
                  color: KColors.main,
                  child: PagedListView(
                    padding: const EdgeInsets.only(top: 4.0),
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Poke>(
                      firstPageProgressIndicatorBuilder: (context) =>
                          const LoadingIndicator(),
                      firstPageErrorIndicatorBuilder: (context) => ErrorScreen(
                        () => _pagingController.refresh(),
                      ),
                      newPageProgressIndicatorBuilder: (context) =>
                          const TinyLoading(),
                      newPageErrorIndicatorBuilder: (context) => TinyError(
                        onTap: () => _pagingController.retryLastFailedRequest(),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => const Center(
                        child: Text('No item found'),
                      ),
                      itemBuilder: (context, item, index) {
                        return _PokemonCard(
                            poke: item, onTap: () => callModal(item));
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }

  void callModal(Poke poke) {
    _vm.fetchPokemon(poke.id!);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: KColors.blue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return SizedBox(
              height: 350,
              child: Center(
                child: Observer(
                  builder: (_) {
                    return _vm.loadingDetail
                        ? const LoadingIndicator(
                            color: Colors.white,
                          )
                        : _vm.detailError
                            ? Center(
                                child: ErrorScreen(
                                  () => _vm.fetchPokemon(poke.id!),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 120.0,
                                          width: 120.0,
                                          child: OverflowBox(
                                            alignment: Alignment.center,
                                            maxHeight: 140,
                                            maxWidth: 140,
                                            child: CachedNetworkImage(
                                              imageUrl: poke.getAddress(),
                                              placeholder: (context, url) =>
                                                  Container(
                                                color: Colors.transparent,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.file(
                                                File(poke.url!),
                                                height: 100.0,
                                                width: 100.0,
                                              ),
                                              fit: BoxFit.cover,
                                              height: 140,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 8.0),
                                              Text(
                                                '#${poke.id} ${poke.name}',
                                                style: KTextStyle.modal1,
                                              ),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                _vm.pokemonDetail.category,
                                                style: KTextStyle.modal2,
                                              ),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                _vm.pokemonDetail.ability,
                                                style: KTextStyle.modal2,
                                              ),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                _vm.pokemonDetail.type,
                                                style: KTextStyle.modal2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              child: IconButton(
                                                onPressed: () {
                                                  this.setState(() {});
                                                  setState(() {
                                                    poke.favorite =
                                                        !poke.favorite;
                                                  });
                                                },
                                                icon: Icon(
                                                  poke.favorite
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: KColors.yellow,
                                                  size: 32.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      _vm.pokemonDetail.description,
                                      style: KTextStyle.modal2,
                                      textAlign: TextAlign.justify,
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 233.0,
                                      child: ElevatedButton(
                                        child: const Text(
                                          'Gotta Catch \'Em All!',
                                          style: KTextStyle.modal3,
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(
                                          primary: KColors.darkBlue,
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(17.0),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _PokemonCard extends StatelessWidget {
  const _PokemonCard({
    Key? key,
    required this.poke,
    required this.onTap,
  }) : super(key: key);

  final Poke poke;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    String _name;
    if (poke.name?.isEmpty ?? true) {
      _name = 'No name';
    } else {
      _name = poke.name!;
    }
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 4.0, 0.0),
            child: CircleAvatar(
              backgroundColor: KColors.avatar,
              radius: 24.0,
              child: CachedNetworkImage(
                imageUrl: poke.getAddress(),
                placeholder: (context, url) => Container(
                  color: Colors.transparent,
                ),
                errorWidget: (context, url, error) => Image.file(
                  File(poke.url!),
                  height: 32.0,
                  width: 32.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  dense: true,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: KColors.text,
                  ),
                  title: Row(
                    children: [
                      Text(
                        _name.capitalize,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: KTextStyle.listTile1,
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      poke.favorite
                          ? const Icon(
                              Icons.star,
                              size: 16,
                              color: KColors.yellow,
                            )
                          : Container()
                    ],
                  ),
                  subtitle: Text(
                    "#${poke.id}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KTextStyle.listTile2,
                  ),
                ),
                const Divider(
                  thickness: 0.8,
                  indent: 16.0,
                  height: 0.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

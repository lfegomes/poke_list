import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core_packages.dart';
import '../viewmodel/poke_viewmodel.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final _vm = GetIt.I<PokeViewModel>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBar = AppBar(
      centerTitle: true,
      backgroundColor: KColors.main,
      title: const Text(
        'POKEDEX',
        style: KTextStyle.appBar,
      ),
    );
    var appBarHeight = appBar.preferredSize.height;
    var allowHeight = height - statusBarHeight - appBarHeight - 50.0;
    var cardWidth = (width - 70.0) / 2;
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          OverflowBox(
            alignment: const Alignment(0, -0.8),
            maxHeight: allowHeight,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2), BlendMode.dstATop),
              child: SvgPicture.asset(
                "assets/ash.svg",
                fit: BoxFit.fitHeight,
                height: allowHeight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              SizedBox(
                height: 145,
                child: SvgPicture.asset(
                  "assets/poke_logo.svg",
                  height: 145,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _YellowCard(
                    cardWidth: cardWidth,
                    onTap: () => _vm.setCurrentPage(1),
                    text1: 'Veja os Pokémons da primeira geração',
                    text2: 'Visualizar Pokémons',
                  ),
                  _YellowCard(
                    cardWidth: cardWidth,
                    onTap: () => _vm.setCurrentPage(2),
                    text1: 'Crie já seu próprio Pokémon',
                    text2: 'Cadastrar novo Pokémon',
                  ),
                ],
              ),
              Flexible(
                flex: 10,
                child: Container(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'As circunstâncias do nascimento de alguém são irrelevantes; é o que você faz com o dom da vida que determina quem você é.',
                  style: KTextStyle.dashMessage,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
                child: const Text(
                  'Mewtwo',
                  style: KTextStyle.dashMessage,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _YellowCard extends StatelessWidget {
  const _YellowCard({
    Key? key,
    required this.cardWidth,
    required this.onTap,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final double cardWidth;
  final VoidCallback onTap;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: KColors.yellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: SizedBox(
        width: cardWidth,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(9.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Column(
              children: [
                Text(
                  text1,
                  style: KTextStyle.yellowCard1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  text2,
                  style: KTextStyle.yellowCard2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

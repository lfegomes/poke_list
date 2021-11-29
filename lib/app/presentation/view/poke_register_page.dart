import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poke_list/app/presentation/components/error_screen.dart';
import 'package:poke_list/app/presentation/components/loading_indicator.dart';

import '../../../core/core_packages.dart';
import '../viewmodel/poke_viewmodel.dart';

class PokeRegisterPage extends StatefulWidget {
  const PokeRegisterPage({Key? key}) : super(key: key);

  @override
  _PokeRegisterPageState createState() => _PokeRegisterPageState();
}

class _PokeRegisterPageState extends State<PokeRegisterPage> {
  final _vm = GetIt.I<PokeViewModel>();
  final _formKey = GlobalKey<FormState>();

  File? image;
  String? imagePath;

  Future<void> pickNewImage() async {
    try {
      final response =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (response == null) return;
      imagePath = response.path;
      setState(() {
        image = File(imagePath!);
      });
    } on PlatformException catch (e) {
      const snackBar = SnackBar(
        content: Text('Erro ao selecionar imagem'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  List<DropdownMenuItem<String>> get categoryItems {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var element in _vm.categories) {
      menuItems.add(
        DropdownMenuItem(child: Text(element.name!), value: element.name!),
      );
    }
    return menuItems;
  }

  List<DropdownMenuItem<String>> get typeItems {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var element in _vm.types) {
      menuItems.add(
        DropdownMenuItem(child: Text(element.name!), value: element.name!),
      );
    }
    return menuItems;
  }

  List<DropdownMenuItem<String>> get abilityItems {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var element in _vm.abilities) {
      menuItems.add(
        DropdownMenuItem(child: Text(element.name!), value: element.name!),
      );
    }
    return menuItems;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      _vm.fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KColors.main,
        title: const Text(
          'CADASTRE SEU POKÉMON',
          style: KTextStyle.appBar,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => _vm.setCurrentPage(0),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Observer(
          builder: (_) {
            return _vm.loadingItems
                ? const Center(
                    child: LoadingIndicator(),
                  )
                : _vm.itemsError
                    ? Center(
                        child: ErrorScreen(
                          () => _vm.fetchItems(),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                          child: Column(
                            children: [
                              const Text(
                                'Crie seu próprio Pokémon',
                                style: KTextStyle.register1,
                              ),
                              const SizedBox(height: 24.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => pickNewImage(),
                                    child: Column(
                                      children: [
                                        image == null
                                            ? SvgPicture.asset(
                                                "assets/poke_ball.svg",
                                                height: 125,
                                                width: 125,
                                              )
                                            : Image.file(
                                                image!,
                                                height: 125,
                                                width: 125,
                                              ),
                                        FormField(
                                          onSaved: (value) =>
                                              _vm.imagePath = imagePath,
                                          validator: (value) {
                                            return image == null
                                                ? 'Campo obrigatório'
                                                : null;
                                          },
                                          builder: (FormFieldState<int> state) {
                                            return Column(
                                              children: [
                                                const Text(
                                                  'Editar',
                                                  style: KTextStyle.register2,
                                                ),
                                                if (state.hasError) ...[
                                                  const Text(
                                                    'Campo obrigatório',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ]
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Nome do Pokémon',
                                        hintStyle: KTextStyle.register2,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: KColors.darkBlue),
                                        ),
                                      ),
                                      validator: (value) {
                                        return value!.isEmpty
                                            ? 'Campo obrigatório'
                                            : null;
                                      },
                                      onSaved: (value) => _vm.name = value!,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField(
                                      validator: (value) => value == null
                                          ? 'Campo obrigatório'
                                          : null,
                                      items: categoryItems,
                                      value: _vm.category,
                                      onChanged: (String? value) =>
                                          _vm.category = value!,
                                      style: KTextStyle.register2,
                                      hint: const Text(
                                        'Categoria',
                                        style: KTextStyle.register2,
                                      ),
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ),
                                  const SizedBox(width: 32.0),
                                  Expanded(
                                    child: DropdownButtonFormField(
                                      validator: (value) => value == null
                                          ? 'Campo obrigatório'
                                          : null,
                                      items: typeItems,
                                      value: _vm.type,
                                      onChanged: (String? value) =>
                                          _vm.type = value!,
                                      style: KTextStyle.register2,
                                      hint: const Text(
                                        'Tipo',
                                        style: KTextStyle.register2,
                                      ),
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24.0),
                              DropdownButtonFormField(
                                validator: (value) =>
                                    value == null ? 'Campo obrigatório' : null,
                                items: abilityItems,
                                value: _vm.ability,
                                onChanged: (String? value) =>
                                    _vm.ability = value!,
                                style: KTextStyle.register2,
                                hint: const Text(
                                  'Habilidades',
                                  style: KTextStyle.register2,
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down),
                              ),
                              const SizedBox(height: 32.0),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  labelText: 'Descrição',
                                  labelStyle: KTextStyle.register2,
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: KColors.darkBlue),
                                  ),
                                ),
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Campo obrigatório'
                                      : null;
                                },
                                onSaved: (value) => _vm.description = value!,
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: 233.0,
                                child: ElevatedButton(
                                  child: const Text(
                                    'Salvar',
                                    style: KTextStyle.modal3,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: KColors.darkBlue,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    final isValid =
                                        _formKey.currentState!.validate();
                                    if (isValid) {
                                      _formKey.currentState!.save();
                                      _vm.saveNewPokemon();
                                      _vm.setCurrentPage(0);
                                      var snackBar = SnackBar(
                                        content: Text(
                                            'Pokemón criado. Id: ${_vm.newId! - 1}'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }
}

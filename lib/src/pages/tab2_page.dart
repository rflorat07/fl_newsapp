import 'package:fl_newsapp/src/theme/tema.dart';
import 'package:fl_newsapp/src/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_newsapp/src/services/services.dart';
import 'package:fl_newsapp/src/models/category_model.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            const _ListaCategorias(),
            Expanded(
                child: ListaNoticias(
                    noticias: newsService.getArticulosCategoriaSeleccionada))
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
        width: double.infinity,
        height: 80,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final cName = categories[index].name;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _CategoryButton(
                    categoria: categories[index],
                  ),
                  const SizedBox(height: 5),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
                ],
              ),
            );
          },
        ));
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;
  const _CategoryButton({required this.categoria});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == categoria.name)
              ? miTema.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/category_model.dart';
import 'package:flutter_news_app/src/services/services.dart';
import 'package:flutter_news_app/src/theme/tema.dart';
import 'package:flutter_news_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatelessWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsCategory = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const _ListaCategorias(),
          const SizedBox(
            height: 10,
          ),
          if ( !newsCategory.isLoading )
            Expanded(child: ListaNoticias(noticias: newsCategory.getSelectedCategory)),

          if ( newsCategory.isLoading )
            Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: darkTheme.primaryColorDark,),
                )
              )

        ],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias();

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).category;

    return SizedBox(
      width: double.infinity,
      height: 81,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final String cName = categories[index].name;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                const SizedBox(height: 5),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton(
    this.category,
  );

  final Category category;

  @override
  Widget build(BuildContext context) {
    final searchCategory = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        
        searchCategory.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          category.icon,
          color: (searchCategory.selectedCategory == category.name) ? darkTheme.primaryColorDark :Colors.black54,
        ),
      ),
    );
  }
}

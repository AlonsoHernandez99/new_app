import 'package:flutter/material.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/theme/dark_theme.dart';
import 'package:news_app/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          _CategoryList(),
          Expanded(child: NewsList(newsService.articlesByCategory))
        ],
      )),
    );
  }
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80.0,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final categoryName = categories[index].name;
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _CategoryButton(categories[index]),
                    SizedBox(height: 5.0),
                    Text(
                        '${categoryName[0].toUpperCase()}${categoryName.substring(1)}')
                  ],
                ));
          }),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            category.icon,
            color: newsService.selectedCategory == category.name
                ? darkTheme.accentColor
                : Colors.black54,
          )),
    );
  }
}

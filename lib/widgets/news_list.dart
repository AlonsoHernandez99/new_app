import 'package:flutter/material.dart';
import 'package:news_app/models/news_models.dart';
import 'package:news_app/theme/dark_theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;
  NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: news.length,
        itemBuilder: (BuildContext context, int i) {
          return _New(article: this.news[i], index: i);
        });
  }
}

class _New extends StatelessWidget {
  final Article article;
  final int index;

  const _New({this.article, this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBarCard(article, index),
        _TitleCard(article),
        _ImageCard(article),
        _BodyCard(article),
        _CardActions(),
        SizedBox(height: 10.0),
        Divider(),
      ],
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article article;
  final int index;

  const _TopBarCard(this.article, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text(
            "${index + 1} - ",
            style: TextStyle(color: darkTheme.accentColor),
          ),
          Text("${article.source.name}"),
        ],
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article article;
  const _TitleCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        article.title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article article;

  const _ImageCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: article.urlToImage != null
              ? FadeInImage(
                  placeholder: AssetImage('assets/loader.gif'),
                  image: NetworkImage(article.urlToImage),
                )
              : Image(image: AssetImage('assets/no-image.png')),
        ),
      ),
    );
  }
}

class _BodyCard extends StatelessWidget {
  final Article article;

  const _BodyCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(article.description != null ? article.description : ''),
    );
  }
}

class _CardActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          child: Icon(Icons.star_border),
          fillColor: darkTheme.accentColor,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(width: 10.0),
        RawMaterialButton(
          child: Icon(Icons.more),
          fillColor: Colors.blueAccent,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        )
      ],
    ));
  }
}

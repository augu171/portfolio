import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;
  const ListNews(this.news, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.news.length,
        itemBuilder: (BuildContext context, int index) {
          return _ANews(aNews: this.news[index], index: index);
        });
  }
}

class _ANews extends StatelessWidget {
  final Article aNews;
  final int index;

  const _ANews({required this.aNews, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CardTopBar(aNews, index),
        _CardTitle(aNews),
        _CardImage(aNews),
        _CardBody(aNews),
        SizedBox(height: 10),
        _CardButtons(),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}

class _CardButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: null,
            fillColor: darkTheme.accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.heart_broken_outlined),
          ),
          const SizedBox(width: 50),
          RawMaterialButton(
            onPressed: null,
            fillColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.sentiment_satisfied_outlined),
          ),
        ],
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article aNews;

  const _CardBody(this.aNews);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((aNews.description) != '' ? aNews.description : ''),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article aNews;

  const _CardImage(this.aNews);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
          // bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        child: Container(
          child: (aNews.urlToImage != '')
              ? FadeInImage(
                  placeholder: const AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(Uri.parse(aNews.urlToImage).toString()),
                )
              : const Image(
                  image: AssetImage('assets/img/no-image.png'),
                ),
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article aNews;

  const _CardTitle(this.aNews);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        aNews.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article aNews;
  final int index;
  const _CardTopBar(this.aNews, this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(children: <Widget>[
        Text(
          '${index + 1}. ',
          style: TextStyle(color: darkTheme.accentColor),
        ),
        Text('${aNews.source.name}'),
      ]),
    );
  }
}

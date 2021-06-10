import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:nepal_sansar/model/news.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemWidget extends StatelessWidget {
  final News news;

  const ItemWidget({Key? key, required this.news})
      // ignore: unnecessary_null_comparison
      : assert(news != null),
        super(key: key);

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    final String url = news.jetpackFeaturedMediaUrl;
    return Card(
        child: Row(
      children: [
        Hero(
          tag: Key(news.id.toString()),
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ).box.rounded.p8.color(Colors.white12).make().p1().w48(context),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _parseHtmlString(news.title.rendered)
                  .text
                  .lg
                  .color(Colors.black)
                  .bold
                  .ellipsis
                  .start
                  .maxLines(2)
                  .make(),
              5.heightBox,
              _parseHtmlString(news.excerpt.rendered)
                  .text
                  .lg
                  .color(Colors.black54)
                  .bold
                  .ellipsis
                  .start
                  .textStyle(context.captionStyle!)
                  .maxLines(2)
                  .make(),
              10.heightBox,
              news.date.text.lg
                  .color(Colors.black26)
                  .textStyle(context.captionStyle!)
                  .make()
            ],
          ),
        )
      ],
    ));
  }
}

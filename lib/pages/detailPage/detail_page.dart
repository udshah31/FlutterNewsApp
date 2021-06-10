import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:nepal_sansar/model/news.dart';

class DetailPage extends StatelessWidget {
  final News news;

  const DetailPage({Key? key, required this.news})
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white60,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(news.id.toString()),
              child: CachedNetworkImage(
                imageUrl: news.jetpackFeaturedMediaUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ).h32(context),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: VxArc(
                  height: 25,
                  arcType: VxArcType.CONVEY,
                  edge: VxEdge.TOP,
                  child: Container(
                    color: Colors.white,
                    width: context.screenWidth,
                    child: Column(
                      children: [
                        _parseHtmlString(news.title.rendered)
                            .text
                            .xl3
                            .color(Colors.black)
                            .bold
                            .make()
                            .p16(),
                        _parseHtmlString(news.excerpt.rendered)
                            .text
                            .textStyle(context.captionStyle!)
                            .xl2
                            .make()
                            .p16(),
                        _parseHtmlString(news.content.rendered)
                            .text
                            .textStyle(context.captionStyle!)
                            .xl2
                            .make()
                            .p16(),
                      ],
                    ).py16(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

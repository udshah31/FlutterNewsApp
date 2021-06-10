import 'package:flutter/material.dart';
import 'package:nepal_sansar/model/news.dart';
import 'package:nepal_sansar/network/news_service.dart';
import 'package:nepal_sansar/pages/detailPage/detail_page.dart';
import 'package:nepal_sansar/widgets/item_widget.dart';


class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
   int page = 1;
  List<News> _list = [];
  ScrollController _scrollController = ScrollController();

@override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreList();
      }
    });
  }

  _getMoreList() async {
    int nextPage = page++;
    var list = await NewsService.getNews(page: nextPage);
    _list.addAll(list);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<News>>(
        future: NewsService.getNews(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (data.connectionState == ConnectionState.done) {
            return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(news: data.data![index])),
                  ),
                  child: ItemWidget(
                    news: data.data![index],
                  ),
                );

                // now get your data data into widget , when you re done , tell me if it works
              },
              itemCount: data.data!.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


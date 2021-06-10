import 'package:flutter/material.dart';
import 'package:nepal_sansar/model/news.dart';
import 'package:nepal_sansar/network/news_service.dart';
import 'package:nepal_sansar/pages/detailPage/detail_page.dart';
import 'package:nepal_sansar/pagination/refresh_configuration.dart';
import 'package:nepal_sansar/widgets/item_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfig();
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  int page = 1;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<News> data = [];
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    NewsService.getHealthNews().then((dataFromServer) {
      setState(() {
        data = dataFromServer;
      });
    });
  }

  void _onRefresh() async {
    print("_onRefresh");
    await Future.delayed(Duration(seconds: 2));
    var list = await NewsService.getHealthNews(page: 1);
    data.clear();
    page = 1;
    data.addAll(list);
    setState(() {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    print("_onloading");
    page++;
    var list = await NewsService.getHealthNews(page: page);
    data.addAll(list);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _refreshController.loadComplete();
    });
  }

  Widget buildCtn() {
    // ignore: unnecessary_null_comparison
    return (data != null && data.isNotEmpty)
        ? ListView.builder(
            key: _contentKey,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(news: data[index]))),
                child: ItemWidget(news: data[index]),
              );
            },
            itemCount: data.length)
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      enableLoadingWhenFailed: true,
      enableLoadingWhenNoData: true,
      child: Scaffold(
        body: SmartRefresher(
          key: _refresherKey,
          controller: _refreshController,
          enablePullUp: true,
          child: buildCtn(),
          physics: BouncingScrollPhysics(),
          footer: ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
        ),
      ),
      headerBuilder: () => WaterDropMaterialHeader(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      footerTriggerDistance: 30,
    );
  }
}

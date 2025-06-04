// 99609259bd0f4b5a9bbabca9649eda42
// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  // body: ListNews(headlines)
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsService>(context).headlines;
    return Scaffold(
      body: (headlines.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListNews(headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

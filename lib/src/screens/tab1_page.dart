import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/services/services.dart';
import 'package:flutter_news_app/src/theme/tema.dart';
import 'package:flutter_news_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({Key? key}) : super(key: key);

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      body: (newsService.headline.isEmpty)
      ? Center(child: CircularProgressIndicator(color: darkTheme.primaryColorDark,),)
      : ListaNoticias(noticias: newsService.headline)
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

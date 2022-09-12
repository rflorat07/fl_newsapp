import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_newsapp/src/widgets/widgets.dart';
import 'package:fl_newsapp/src/services/services.dart';

class Tab1Page extends StatefulWidget {
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsService>(context).headlines;
    return Scaffold(
        body: (headlines.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : ListaNoticias(noticias: headlines));
  }

  @override
  bool get wantKeepAlive => true;
}

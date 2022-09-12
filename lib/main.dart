import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_newsapp/src/theme/tema.dart';
import 'package:fl_newsapp/src/pages/pages.dart';
import 'package:fl_newsapp/src/services/news_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsService(),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: const TabsPage(),
      ),
    );
  }
}

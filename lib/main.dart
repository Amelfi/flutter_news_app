import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/screens/screens.dart';
import 'package:flutter_news_app/src/services/services.dart';
import 'package:flutter_news_app/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(const FullState());

class FullState extends StatelessWidget {
  const FullState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => NewsService())
    ],
    child: const MyApp(),
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const TabsScreen(),
      theme: darkTheme,
    );
  }
}
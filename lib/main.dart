import 'package:flutter/material.dart';
import 'package:nasa_apod/screens/my_home_page.dart';
import 'package:nasa_apod/viewmodel/app_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppModel(),
      child:
          Consumer<AppModel>(builder: (context, AppModel themeNotifier, child) {
        return MaterialApp(
          title: 'NASA APOD',
          theme: themeNotifier.isDark
              ? ThemeData.dark().copyWith()
              : ThemeData.light().copyWith(
                  textTheme: const TextTheme(
                    bodyText2: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        );
      }),
    );
  }
}

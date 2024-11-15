import 'package:flutter/material.dart';
import 'package:uts_pemmob/models/wisata_model.dart';
import 'core/navigation_service.dart';
import 'presentation/pages/homepage.dart';
import 'presentation/pages/detailpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Indonesia',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final wisata = settings.arguments as Wisata;
          return MaterialPageRoute(
            builder: (context) => DetailPage(wisata: wisata),
          );
        }
        return MaterialPageRoute(builder: (context) => HomePage());
      },
    );
  }
}

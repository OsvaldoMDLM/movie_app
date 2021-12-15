import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/src/pages/pages.dart';
import 'package:movie_app/src/providers/movies_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
      ],
      // ignore: prefer_const_constructors
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
      )),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'details': (_) => const DetailPage(),
      },
    );
  }
}

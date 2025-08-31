import 'package:estudos_cp/screens/select.dart';
import 'package:estudos_cp/screens/home.dart';
import 'package:flutter/material.dart';
import '../model/time.dart';

class Routes {
  static const String home = '/home';
  static const String select = '/select';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case select:
        final time = settings.arguments as Time; // pega o argumento passado
        return MaterialPageRoute(builder: (_) => SelectPage(time: time));
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Rota não encontrada!'))),
        );
    }
  }
}

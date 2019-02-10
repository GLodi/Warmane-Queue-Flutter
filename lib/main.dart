import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'package:warmane_queue_checker_flutter/domain/domain.dart';
import 'package:warmane_queue_checker_flutter/data/data.dart';
import 'package:warmane_queue_checker_flutter/presentation/home_screen.dart';

void main() {
  kiwi.Container container = new kiwi.Container();
  container.registerSingleton((c) =>
    new NetUtils());
  container.registerSingleton((c) =>
    new WebHelper(c.resolve<NetUtils>()));
  container.registerSingleton((c) =>
    new WarmaneManager(c.resolve<WebHelper>()));
  container.registerSingleton((c) =>
    new WarmaneBloc(c.resolve<WarmaneManager>()));

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BlocProvider(
          child: HomeScreen(),
          bloc: kiwi.Container().resolve<WarmaneBloc>(),
        ),
      ),
    );
  }
}
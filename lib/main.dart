import 'package:bip_card_info/bloc/bloc.dart';
import 'package:bip_card_info/repositories/repositories.dart';

import 'package:bip_card_info/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bipCardRepository = BipCardRepository(
      bipCardApiClient: BipCardApiClient(
    httpClient: http.Client(),
  ));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CardBalanceBloc>(
          create: (context) => CardBalanceBloc(bipCardRepository: bipCardRepository),
        ),
        BlocProvider<CardMovementsBloc>(
          create: (context) => CardMovementsBloc(bipCardRepository: bipCardRepository),
        )
      ],
      child: MaterialApp(
        title: 'Bip Info App',
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}

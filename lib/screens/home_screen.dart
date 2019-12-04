import 'package:bip_card_info/bloc/bloc.dart';
import 'package:bip_card_info/screens/card_info_screen.dart';
import 'package:bip_card_info/widgets/id_bip_card_text_field.dart';
import 'package:bip_card_info/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final cardBalanceBloc = BlocProvider.of<CardBalanceBloc>(context);
    final controlller = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IdBipCardTextField(
                  controller: controlller,
                ),
                SizedBox(height: 25.0),
                SubmitButton(
                  label: "Consultar Tarjeta",
                  onPressed: () {
                    cardBalanceBloc.add(FetchCardBalance(cardId: int.parse(controlller.text)));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardInfoScreen()
                      )
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

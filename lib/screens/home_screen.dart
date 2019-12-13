import 'package:bip_card_info/bloc/bloc.dart';
import 'package:bip_card_info/screens/card_info_screen.dart';
import 'package:bip_card_info/widgets/id_bip_card_text_field.dart';
import 'package:bip_card_info/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final cardBalanceBloc = BlocProvider.of<CardBalanceBloc>(context);
    final controlller = TextEditingController();

    void _scanBarCode() async {
      var code = await FlutterBarcodeScanner.scanBarcode(
          "#004297", "Cancel", true, ScanMode.BARCODE);
      controlller.text = code;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff01A0C7),
        foregroundColor: Colors.white,
        child: Icon(
          Icons.fullscreen,
          size: 40,
        ),
        onPressed: () => _scanBarCode(),
      ),
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
                    cardBalanceBloc.add(
                        FetchCardBalance(cardId: int.parse(controlller.text)));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardInfoScreen()));
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

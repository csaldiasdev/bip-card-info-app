import 'package:flutter/material.dart';

class BipCardFront extends StatelessWidget {

  final String idCardText;

  const BipCardFront({Key key, @required this.idCardText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 0),
            blurRadius: 24,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 300,
            height: 210,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            width: 50,
            height: 210,
            child: RotatedBox(
              quarterTurns: 1,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 18.0),
                  Text(
                    "Nº bip!",
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    idCardText,
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

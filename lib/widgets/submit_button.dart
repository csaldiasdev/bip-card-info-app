import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({@required this.onPressed, @required this.label});

  final GestureTapCallback onPressed;
  final String label;
  final style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10,
      shape: StadiumBorder(),
      color: const Color(0xff01A0C7),
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: onPressed,
      child: Text(label,
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}

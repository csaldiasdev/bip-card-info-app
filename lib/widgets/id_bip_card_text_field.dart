import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

class IdBipCardTextField extends StatelessWidget {

  final TextEditingController controller;

  const IdBipCardTextField({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nª bip!",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }
}

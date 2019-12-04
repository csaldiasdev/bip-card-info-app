import 'package:equatable/equatable.dart';

class CardMovement extends Equatable {
  final String idMovement;
  final String typeMovement;
  final String dateTime;
  final String place;
  final String amount;
  final String balance;

  const CardMovement({
    this.idMovement,
    this.typeMovement,
    this.dateTime,
    this.place,
    this.amount,
    this.balance
  });

  @override
  List<Object> get props => [
    idMovement,
    typeMovement,
    dateTime,
    place,
    amount,
    balance
  ];
}
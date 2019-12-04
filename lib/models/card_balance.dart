import 'package:equatable/equatable.dart';

class CardBalance extends Equatable {
  final String cardNumber;
  final String contractStatus;
  final String cardBalance;
  final String dateBalance;

  const CardBalance({
    this.cardNumber,
    this.contractStatus,
    this.cardBalance,
    this.dateBalance
  });

  @override
  List<Object> get props => [
    cardNumber,
    contractStatus,
    cardBalance,
    dateBalance
  ];
}
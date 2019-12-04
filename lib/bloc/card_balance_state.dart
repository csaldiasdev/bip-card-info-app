import 'package:bip_card_info/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CardBalanceState extends Equatable {
  const CardBalanceState();
  
  @override
  List<Object> get props => [];
}

class CardBalanceEmpty extends CardBalanceState {}

class CardBalanceLoading extends CardBalanceState {}

class CardBalanceLoaded extends CardBalanceState {
  final CardBalance cardBalance;

  CardBalanceLoaded({@required this.cardBalance}) : assert(cardBalance != null);

  @override
  List<Object> get props => [cardBalance];
}

class CardBalanceError extends CardBalanceState {}
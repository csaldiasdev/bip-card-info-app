import 'package:bip_card_info/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CardMovementsState extends Equatable {
  const CardMovementsState();

  @override
  List<Object> get props => [];
}

class CardMovementsEmpty extends CardMovementsState {}

class CardMovementsLoading extends CardMovementsState {}

class CardMovementsLoaded extends CardMovementsState {
  final List<CardMovement> cardMovements;

  CardMovementsLoaded({@required this.cardMovements})
      : assert(cardMovements != null);

  @override
  List<Object> get props => [cardMovements];
}

class CardMovementsError extends CardMovementsState {}

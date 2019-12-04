import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CardMovementsEvent extends Equatable {
  const CardMovementsEvent();
}

class FetchCardMovements extends CardMovementsEvent {
  final int cardId;

  const FetchCardMovements({@required this.cardId}) : assert(cardId != null);

  @override
  List<Object> get props => [cardId];
}
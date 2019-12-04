import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CardBalanceEvent extends Equatable {
  const CardBalanceEvent();
}

class FetchCardBalance extends CardBalanceEvent {
  final int cardId;

  const FetchCardBalance({@required this.cardId}) : assert(cardId != null);

  @override
  List<Object> get props => [cardId];
}
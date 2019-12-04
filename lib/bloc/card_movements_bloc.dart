import 'dart:async';
import 'package:bip_card_info/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class CardMovementsBloc extends Bloc<CardMovementsEvent, CardMovementsState> {
  final BipCardRepository bipCardRepository;

  CardMovementsBloc({@required this.bipCardRepository})
      : assert(bipCardRepository != null);

  @override
  CardMovementsState get initialState => CardMovementsEmpty();

  @override
  Stream<CardMovementsState> mapEventToState(
    CardMovementsEvent event,
  ) async* {
    if (event is FetchCardMovements) {
      yield CardMovementsLoading();
      try {
        final cardMovements = await bipCardRepository.getCardMovements(event.cardId);
        yield CardMovementsLoaded(cardMovements: cardMovements);
      } catch (_) {
        yield CardMovementsError();
      }
    }
  }
}

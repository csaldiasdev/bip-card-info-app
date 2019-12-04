import 'dart:async';
import 'package:bip_card_info/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class CardBalanceBloc extends Bloc<CardBalanceEvent, CardBalanceState> {
  final BipCardRepository bipCardRepository;

  CardBalanceBloc({@required this.bipCardRepository})
      : assert(bipCardRepository != null);

  @override
  CardBalanceState get initialState => CardBalanceEmpty();

  @override
  Stream<CardBalanceState> mapEventToState(
    CardBalanceEvent event,
  ) async* {
    if (event is FetchCardBalance) {
      yield CardBalanceLoading();
      try {
        final cardBalance =
            await bipCardRepository.getCardBalance(event.cardId);
        yield CardBalanceLoaded(cardBalance: cardBalance);
      } catch (_) {
        yield CardBalanceError();
      }
    }
  }
}

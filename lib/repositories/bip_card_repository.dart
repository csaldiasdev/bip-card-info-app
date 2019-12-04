import 'package:bip_card_info/models/models.dart';
import 'package:bip_card_info/repositories/bip_card_api_client.dart';

import 'package:meta/meta.dart';

class BipCardRepository {
  final BipCardApiClient bipCardApiClient;

  BipCardRepository({@required this.bipCardApiClient})
      : assert(bipCardApiClient != null);

  Future<CardBalance> getCardBalance(int cardId) async =>
      await bipCardApiClient.fetchCardBalance(cardId);
  Future<List<CardMovement>> getCardMovements(int cardId) async =>
      await bipCardApiClient.fetchCardMovements(cardId);
}

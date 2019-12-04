import 'dart:developer';

import 'package:bip_card_info/models/models.dart';
import 'package:html/parser.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class BipCardApiClient {
  final http.Client httpClient;

  static const baseUrl = 'http://pocae.tstgo.cl/PortalCAE-WAR-MODULE';
  static const requestHeaders = {
    "Content-Type": "application/x-www-form-urlencoded"
  };

  BipCardApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<CardBalance> fetchCardBalance(int cardId) async {
    log("FETCH CARD: $cardId");
    final locationUrl = '$baseUrl/SesionPortalServlet';

    var bodyBalanceRequest =
        'accion=6&NumDistribuidor=99&NomUsuario=usuInternet&NomHost=AFT&NomDominio=aft.cl&Trx=&RutUsuario=0&NumTarjeta=$cardId&bloqueable=';

    var balanceResponse = await this
        .httpClient
        .post(locationUrl, headers: requestHeaders, body: bodyBalanceRequest);

    var balanceDocument = parse(balanceResponse.body);

    var balanceElements =
        balanceDocument.querySelectorAll('tr > td.verdanabold-ckc');

    var balance = CardBalance(
        cardNumber: balanceElements[1].innerHtml,
        contractStatus: balanceElements[3].innerHtml,
        cardBalance: balanceElements[5].innerHtml,
        dateBalance: balanceElements[7].innerHtml);

    log("CARD INFO: ${balance.props}");

    return balance;
  }

  Future<List<CardMovement>> fetchCardMovements(int cardId) async {
    log("FETCH CARD MOVEMENTS: $cardId");

    final locationUrlBalance = '$baseUrl/SesionPortalServlet';
    final locationUrlMovements = '$baseUrl/ComercialesPortalServlet';

    var bodyBalanceRequest =
        'accion=6&NumDistribuidor=99&NomUsuario=usuInternet&NomHost=AFT&NomDominio=aft.cl&Trx=&RutUsuario=0&NumTarjeta=$cardId&bloqueable=';

    var balanceResponse = await this.httpClient.post(locationUrlBalance,
        headers: requestHeaders, body: bodyBalanceRequest);

    var balanceDocument = parse(balanceResponse.body);

    var ksi = balanceDocument.getElementById("KSI").attributes["value"];

    var date = DateTime.now();

    var fechaInicioMovimientos = "${date.year}${date.month}${date.day}";
    var fechalogeo =
        "${date.year}${date.month}${date.day}${date.hour}${date.minute}${date.second}";

    var bodyMovementsRequest =
        "accion=1&KSI=$ksi&DiasMov=90&FechaInicioMovimientos=$fechaInicioMovimientos&itemms=3000&item=2&fechalogeo=$fechalogeo&cboSeleccion=90";

    var movementsResponse = await this.httpClient.post(locationUrlMovements,
        headers: requestHeaders, body: bodyMovementsRequest);

    var movementsDocument = parse(movementsResponse.body);

    var resultMovements = List<CardMovement>();

    var currentRow = 0;

    var row = movementsDocument.getElementById("fila_$currentRow");

    while (row != null) {
      var movement = CardMovement(
        idMovement: row.children[1].innerHtml.replaceAll("&nbsp;", ""),
        typeMovement: row.children[2].innerHtml.replaceAll("&nbsp;", ""),
        dateTime: row.children[3].innerHtml.replaceAll("&nbsp;", ""),
        place: row.children[4].innerHtml.replaceAll("&nbsp;", ""),
        amount: row.children[5].innerHtml.replaceAll("&nbsp;", ""),
        balance: row.children[6].innerHtml.replaceAll("&nbsp;", ""),
      );

      resultMovements.add(movement);

      currentRow++;
      row = movementsDocument.getElementById("fila_$currentRow");
    }

    log("TOTAL MOVEMENTS: ${resultMovements.length}");
    return resultMovements;
  }
}

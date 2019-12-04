import 'package:bip_card_info/bloc/bloc.dart';
import 'package:bip_card_info/widgets/bip_card_front.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CardInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final cardMovementsBloc = BlocProvider.of<CardMovementsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Información Bip"),
      ),
      body: Center(child: BlocBuilder<CardBalanceBloc, CardBalanceState>(
        builder: (context, state) {
          if (state is CardBalanceLoading) {
            return SpinKitFadingCircle(
              color: Colors.white,
              size: 50.0,
            );
          }

          if (state is CardBalanceLoaded) {
            cardMovementsBloc.add(FetchCardMovements(
                cardId: int.parse(state.cardBalance.cardNumber)));

            return AnimationConfiguration.synchronized(
              duration: const Duration(milliseconds: 300),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      BipCardFront(idCardText: state.cardBalance.cardNumber),
                      SizedBox(height: 10.0),
                      Text("Saldo Tarjeta",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(height: 2.0),
                      Text(state.cardBalance.cardBalance,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50)),
                      SizedBox(height: 2.0),
                      Text(state.cardBalance.dateBalance,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(height: 15.0),
                      BlocBuilder<CardMovementsBloc, CardMovementsState>(
                        builder: (context, state) {
                          if (state is CardMovementsLoading) {
                            return SpinKitThreeBounce(
                              color: Colors.white,
                              size: 30.0,
                            );
                          }

                          if (state is CardMovementsLoaded) {
                            return Expanded(
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  itemCount: state.cardMovements.length,
                                  itemBuilder: (context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: SlideAnimation(
                                        verticalOffset: 50,
                                        child: FadeInAnimation(
                                          child: Card(
                                            child: ListTile(
                                              leading:
                                                  Icon(Icons.monetization_on),
                                              title: Text('\$${state.cardMovements[index].amount} | ${state.cardMovements[index].place} | ${state.cardMovements[index].dateTime} '),
                                              subtitle: Text('${state.cardMovements[index].typeMovement}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }

                          return Container();
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is CardBalanceError) {
            return Column();
          }

          return Column();
        },
      )),
    );
  }
}

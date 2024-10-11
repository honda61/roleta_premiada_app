import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:roleta_premiada_app/model/item_model.dart';

class RoletaScreen extends StatefulWidget {

  Color arrowColor;
  List<ItemModel> items;
  int duration;

  RoletaScreen({super.key, required this.items, required this.duration, required this.arrowColor});

  @override
  State<StatefulWidget> createState() {
    return _RoletaScreen();
  }
}

class _RoletaScreen extends State<RoletaScreen> {

  StreamController<int> controller = StreamController.broadcast();

  int? itemWin;

  List<FortuneItem> itemsRoleta = [];

  @override
  void initState() {
    for(ItemModel i in widget.items) {
      itemsRoleta.add(
        FortuneItem(
          child: i.getWidget(),
          style: FortuneItemStyle(
            color: i.fundoColor
          )
        )
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: AppBar()),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                opacity: 0.2,
                image: AssetImage("lib/shared/fundo.jpg")
              )
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.black,),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset("lib/shared/trevo.png", width: 30,),
                          Text(" Boa sorte!!!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),)
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12, left: 12),
                          child: FortuneWheel(
                            selected: controller.stream,
                            animateFirst: false,
                            onAnimationEnd: () {
                              _showItemWin(context, constraints);
                            },
                            duration: Duration(seconds: widget.duration),
                            indicators: <FortuneIndicator>[
                              FortuneIndicator(
                                alignment: Alignment.topCenter,
                                child: TriangleIndicator(
                                  color: widget.arrowColor,
                                  width: 30.0,
                                  height: 20.0,
                                  elevation: 3,
                                ),
                              ),
                            ],
                            items: itemsRoleta,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          onPressed: () {
                            int rendomval = Fortune.randomInt(0, widget.items.length); setState(() { controller.add(rendomval); });
                            print(rendomval);
                            setState(() {
                              itemWin = rendomval;
                            });
                          },
                          child: const Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.sync, color: Colors.white,),
                              Text(" Girar", style: TextStyle(color: Colors.white, fontSize: 16),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  void _showItemWin(BuildContext context, BoxConstraints constraints) async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setStateInternal) {
                return AlertDialog(
                  title: Column(
                    children: [
                      const Text("PARABÉNS!!!"),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("lib/shared/win.gif", color: Colors.black12,),
                          Icon(Icons.circle, color: widget.items[itemWin!].fundoColor, size: 150,),
                          if(itemWin != null)
                            widget.items[itemWin!].getWidget()
                        ],
                      ),
                      const Text("Sua recompensa"),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Resgatar", style: TextStyle(color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        }
    );
  }

}
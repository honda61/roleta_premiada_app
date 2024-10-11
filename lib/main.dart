import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roleta_premiada_app/model/item_model.dart';
import 'package:roleta_premiada_app/roleta_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Color arrowColor = Colors.green;

  int duration = 3;

  List colors = [];
  List<IconData> icons = [];

  List<ItemModel> items = [];

  @override
  void initState() {
    colors.addAll([Colors.black, Colors.white]);
    for(Color color in Colors.primaries) {
      colors.add(color);
    }
    for(Color color in Colors.primaries) {
      colors.add(color);
    }
    icons.add(Icons.airplane_ticket);icons.add(Icons.camera_alt);icons.add(Icons.phone_iphone_sharp);icons.add(Icons.catching_pokemon);icons.add(Icons.directions_bike);icons.add(Icons.car_rental);icons.add(Icons.sports_volleyball);icons.add(Icons.laptop_chromebook);icons.add(Icons.account_balance_wallet);icons.add(Icons.motorcycle);icons.add(Icons.headset_rounded);icons.add(Icons.circle_outlined);icons.add(Icons.circle);icons.add(Icons.category_outlined);icons.add(Icons.account_balance);icons.add(Icons.abc);icons.add(Icons.access_alarm);icons.add(Icons.add_chart_outlined);icons.add(Icons.yard);icons.add(Icons.gamepad);icons.add(Icons.sports_gymnastics);icons.add(Icons.work_history_outlined);icons.add(Icons.dashboard);icons.add(Icons.key);icons.add(Icons.radar);icons.add(Icons.radio);icons.add(Icons.radio_button_checked);icons.add(Icons.ramen_dining);icons.add(Icons.rectangle);icons.add(Icons.recommend_sharp);icons.add(Icons.rate_review);icons.add(Icons.terrain);icons.add(Icons.ondemand_video_outlined);icons.add(Icons.eco);icons.add(Icons.egg_outlined);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Configurações da roleta"),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    ListTile(
                      title: const Text("Duração da animação:", style: TextStyle(color: Colors.grey, fontSize: 16),),
                      subtitle: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                if(duration > 0) {
                                  setState(() {
                                    duration--;
                                  });
                                }
                              },
                            ),
                            Text("$duration segundos ${duration == 0 ? "(imediato)" : ""}"),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  duration++;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {
                        _changeColor(context, constraints, arrowColor).then((c) {
                          setState(() {
                            arrowColor = c;
                          });
                        });
                      },
                      title: const Text("Trocar cor da seta:", style: TextStyle(color: Colors.grey, fontSize: 16,)),
                      subtitle: Align(
                        alignment: Alignment.topLeft,
                        child: Icon(Icons.arrow_drop_down, size: 80, color: arrowColor,),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Row(
                        children: [
                          const Text("Itens:", style: TextStyle(color: Colors.grey, fontSize: 16),),
                          IconButton(
                            icon: const Icon(Icons.add_box, color: Colors.green, size: 30,),
                            onPressed: () => _showDialogItem(context, constraints, null),
                          ),
                        ],
                      ),
                      subtitle: items.length == 0 ?
                          const Text("- Nenhum item adicionado!", textAlign: TextAlign.start, style: TextStyle(color: Colors.grey),)
                      : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: index % 2 == 0 ? const Color.fromRGBO(0, 0, 0, 0.03) : Colors.white,
                            child: InkWell(
                              onTap: () {
                                _showDialogItem(context, constraints, index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12, bottom: 12),
                                child: Row(
                                  children: [
                                    Text(" ${(index+1).toString()}.  "),
                                    Expanded(
                                      child: Container(
                                        color: items[index].fundoColor,
                                        child: items[index].getWidget(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                        onPressed: () {
                          if(items.length >= 2) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RoletaScreen(items: items, duration: duration, arrowColor: arrowColor)));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Você deve ter no mínimo 2 items na roleta!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        },
                        child: const Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.play_arrow_outlined, color: Colors.white,),
                            Text("Ir para roleta", style: TextStyle(color: Colors.white, fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<Color> _changeColor(BuildContext context, BoxConstraints constraints, Color defaultColor) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Column(
            children: [
              Icon(Icons.format_paint),
              Text("Escolha uma cor"),
            ],
          ),
          content: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 0.7,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        defaultColor = colors[index];
                        Navigator.of(context).pop();
                      });
                    },
                    child: Container(
                        height: 50,
                        color: colors[index]
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    );
    return defaultColor;
  }

  Future<IconData> _changeIcon(BuildContext context, BoxConstraints constraints, IconData deafultIcon) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Column(
              children: [
                Icon(Icons.insert_emoticon),
                Text("Escolha um icone"),
              ],
            ),
            content: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.7,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          deafultIcon = icons[index];
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          child: Icon(icons[index])
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
    );
    return deafultIcon;
  }

  void _showDialogItem(BuildContext context, BoxConstraints constraints, int? index) {

    GlobalKey<FormState> key = GlobalKey();
    TextEditingController text = TextEditingController(text: index != null ?items[index].label : "");
    IconData icon = Icons.circle;
    Color fundo = Colors.black;
    Color corItem = Colors.deepOrange;

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setStateInternal) {
                return AlertDialog(
                  title: Column(
                    children: [
                      index != null ? const Icon(Icons.edit, color: Colors.blue,) : const Icon(Icons.add_box, color: Colors.green,),
                      Text(index != null ? "Editar item" : "Criar item"),
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: Form(
                      key: key,
                      child: Column(
                        children: [
                            TextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Trocar icone", style: TextStyle(decoration: TextDecoration.underline),),
                                  const SizedBox(width: 12,),
                                  Container(
                                    color: fundo,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(icon, color: corItem,),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                _changeIcon(context, constraints, Icons.circle_outlined).then((v) {
                                  setState(() {
                                    icon = v;
                                  });
                                });
                              },
                            ),
                            TextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Trocar cor do item", style: TextStyle(decoration: TextDecoration.underline),),
                                  const SizedBox(width: 12,),
                                  Container(
                                    color: fundo,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        color: corItem,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                _changeColor(context, constraints, Colors.black).then((v) {
                                  setState(() {
                                    corItem = v;
                                  });
                                });
                              },
                            ),
                          TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text("Trocar cor do fundo", style: TextStyle(decoration: TextDecoration.underline),),
                                const SizedBox(width: 12,),
                                Container(
                                  width: 22,
                                  height: 22,
                                  color: fundo,
                                )
                              ],
                            ),
                            onPressed: () {
                              _changeColor(context, constraints, Colors.white).then((v) {
                                setState(() {
                                  fundo = v;
                                });
                              });
                            },
                          ),
                          const SizedBox(height: 20,),
                            TextFormField(
                              controller: text,
                              onTapOutside: (context) => FocusScope.of(this.context).unfocus(),
                              decoration: const InputDecoration(
                                labelText: "Nome do item",
                                hintText: "Digite aqui...",
                              ),
                              validator: (v) {
                                if(v!.isEmpty) {
                                  return "Nome inválido!";
                                }
                                return null;
                              },
                            ),
                          const SizedBox(height: 50,),
                          if(index != null)
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                              onPressed: () {
                                  setState(() {
                                    items.removeAt(index);
                                  });
                                  Navigator.of(context).pop();
                              },
                              child: const Text("Remover", style: TextStyle(color: Colors.red),),
                            ),
                          const SizedBox(height: 12,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: () {
                              if(key.currentState!.validate()) {
                                if(text.text.isNotEmpty) {
                                  if(index != null) {
                                    items[index].fundoColor = fundo;
                                    items[index].label = text.text;
                                    items[index].itemColor = corItem;
                                    items[index].icon = icon;
                                  } else {
                                    items.add(
                                        ItemModel(icon: icon, label: text.text, fundoColor: fundo, itemColor: corItem)
                                    );
                                  }
                                  Navigator.of(context).pop();
                                  setState(() {
                                  });
                                }
                              }
                            },
                            child: const Text("Confirmar", style: TextStyle(color: Colors.white),),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
          );                                        
        }
    );

  }
}
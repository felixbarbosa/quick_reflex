import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quick_reflex/controller/quick_reflex_controller.dart';
import 'package:quick_reflex/enum/dificuldade.dart';
import 'package:quick_reflex/home.dart';
import 'package:quick_reflex/model/quick_reflex.dart';

class PrePlay extends StatefulWidget {
  final QuickReflexController quickReflexController;
  const PrePlay({super.key, required this.quickReflexController});

  @override
  State<PrePlay> createState() => _PrePlayState();
}

class _PrePlayState extends State<PrePlay> {
  final TextEditingController _nomeCtrl = TextEditingController();
  Dificuldade _dificuldadeSelected = Dificuldade.iniciante;
  final List<int> _indexVelocity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  late QuickReflexController _quickReflexController;

  @override
  void initState() {
    _quickReflexController = widget.quickReflexController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          _quickReflexController.setClickPlay(false);
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text("Informações do jogador",
                      style: TextStyle(fontSize: 20)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Informe o nome do jogador",
                          style: TextStyle(fontSize: 15)),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: _nomeCtrl,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Nome do jogador"),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                  const Divider(),
                  const Text("Informações da partida",
                      style: TextStyle(fontSize: 20)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Selecione a dificuldade",
                          style: TextStyle(fontSize: 15)),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField<Dificuldade>(
                        value: _dificuldadeSelected,
                        items:
                            Dificuldade.values.map((Dificuldade dificuldade) {
                          return DropdownMenuItem<Dificuldade>(
                              value: dificuldade,
                              child: Text(dificuldade.name));
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _dificuldadeSelected = value;
                            });
                            _quickReflexController.setVelocitySelected(0);
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Selecione a velocidade",
                          style: TextStyle(fontSize: 15)),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _indexVelocity.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: InkWell(
                                  onTap: () {
                                    _quickReflexController
                                        .setVelocitySelected(index);
                                  },
                                  child: Observer(
                                    builder: (context) {
                                      return Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            color: _quickReflexController
                                                        .velocitySelected ==
                                                    index
                                                ? Colors.greenAccent
                                                : Colors.white,
                                            border:
                                                Border.all(color: Colors.grey),
                                            shape: BoxShape.circle),
                                        child: Center(
                                            child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(fontSize: 12),
                                        )),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () async {
                      var retorno =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Home(
                              quickReflex: QuickReflex(
                                  nomeJogador: _nomeCtrl.text,
                                  dificuldade: _dificuldadeSelected,
                                  velocidade:
                                      _quickReflexController.velocitySelected +
                                          1));
                        },
                      ));

                      if (retorno == true) {
                        _quickReflexController.setClickPlay(false);
                      }
                    },
                    color: Colors.amber,
                    child: const Text("Jogar"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

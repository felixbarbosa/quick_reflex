import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quick_reflex/controller/quick_reflex_controller.dart';
import 'package:quick_reflex/model/recorde.dart';
import 'package:quick_reflex/pages/records/widgets/card_records.dart';

class ShowRecords extends StatefulWidget {
  final QuickReflexController quickReflexController;
  const ShowRecords({super.key, required this.quickReflexController});

  @override
  State<ShowRecords> createState() => _ShowRecordsState();
}

class _ShowRecordsState extends State<ShowRecords> {
  late QuickReflexController _quickReflexController;
  late List<Recorde> _allRecords;
  List<Recorde> _inicianteRecords = [];
  List<Recorde> _intermedRecords = [];
  List<Recorde> _avancadoRecords = [];
  List<Recorde> _expertRecords = [];

  @override
  void initState() {
    super.initState();
    _quickReflexController = widget.quickReflexController;
    _getDatas();
  }

  Future<void> _getDatas() async {
    _allRecords = await _quickReflexController.readDatasOfTable();

    //Separa todos os recordes por dificuldade
    await Future.wait(_allRecords.map((e) async {
      if (e.difficulty.name == "iniciante") {
        _inicianteRecords.add(e);
      } else if (e.difficulty.name == "intermediario") {
        _intermedRecords.add(e);
      } else if (e.difficulty.name == "avancado") {
        _avancadoRecords.add(e);
      } else {
        _expertRecords.add(e);
      }
    }));

    _inicianteRecords =
        (await _orderList(_inicianteRecords)) ?? _inicianteRecords;
    _intermedRecords = (await _orderList(_intermedRecords)) ?? _intermedRecords;
    _avancadoRecords = (await _orderList(_avancadoRecords)) ?? _avancadoRecords;
    _expertRecords = (await _orderList(_expertRecords)) ?? _expertRecords;
  }

  Future<List<Recorde>?> _orderList(List<Recorde> recordes) async {
    //Ordenar os recordes de cada dificuldade
    //Tempo de reação menor (Peso 1)
    //Velocidade maior (Peso 2)
    //Diferença entre acerto e velociade (Peso 3)

    try {
      //Ordenação por diferença entre acerto e velociade
      recordes.sort((a, b) {
        if ((a.hitPercentage + a.velocity) > (b.hitPercentage + b.velocity)) {
          return -1;
        } else if ((a.hitPercentage + a.velocity) ==
            (b.hitPercentage + b.velocity)) {
          if (a.averageTime < b.averageTime) {
            return -1;
          } else if (a.averageTime > b.averageTime) {
            return 1;
          } else {
            return 0;
          }
        } else {
          return 1;
        }
      });

      return recordes;
    } catch (erro) {
      print("Erro no sort: $erro");
      return null;
    }
  }

  Widget _listRecords(List<Recorde> recordes) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 8,
        );
      },
      itemCount: recordes.length,
      itemBuilder: (context, index) {
        return CardRecords(
          isTheBest: index == 0,
          recorde: recordes[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Recordes"),
            bottom: const TabBar(tabs: [
              Tab(text: "Iniciante"),
              Tab(text: "Intermediário"),
              Tab(text: "Avançado"),
              Tab(text: "Expert")
            ]),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
            child: Observer(
              builder: (context) {
                if (_quickReflexController.isLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                } else {
                  if (_quickReflexController.recordes.isEmpty) {
                    return const Text("Nenhum recorde registrado...");
                  } else {
                    return RefreshIndicator(
                      onRefresh: _getDatas,
                      child: TabBarView(
                        children: [
                          _listRecords(_inicianteRecords),
                          _listRecords(_intermedRecords),
                          _listRecords(_avancadoRecords),
                          _listRecords(_expertRecords)
                        ],
                      ),
                    );
                  }
                }
              },
            ),
          )),
    );
  }
}

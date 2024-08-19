import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quick_reflex/pages/records/widgets/card_records.dart';
import 'package:quick_reflex/controller/quick_reflex_controller.dart';
import 'package:quick_reflex/model/recorde.dart';

class ShowRecords extends StatefulWidget {
  final QuickReflexController quickReflexController;
  const ShowRecords({super.key, required this.quickReflexController});

  @override
  State<ShowRecords> createState() => _ShowRecordsState();
}

class _ShowRecordsState extends State<ShowRecords> {
  late QuickReflexController _quickReflexController;
  late List<Recorde> _records;

  @override
  void initState() {
    super.initState();
    _quickReflexController = widget.quickReflexController;
    _getDatas();
  }

  Future<void> _getDatas() async {
    _records = await _quickReflexController.readDatasOfTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recordes"),
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
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: _records.length,
                      itemBuilder: (context, index) {
                        return CardRecords(
                          isTheBest: index == 0,
                          recorde: _records[index],
                        );
                      },
                    ),
                  );
                }
              }
            },
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quick_reflex/controller/quick_reflex_controller.dart';
import 'package:quick_reflex/pages/play/pre_play.dart';
import 'package:quick_reflex/pages/records/index/show_records.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final QuickReflexController _quickController = QuickReflexController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Quick Reflex",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                MaterialButton(
                  onPressed: () => _quickController.setClickPlay(true),
                  color: Colors.amber,
                  child: const Text("Jogar"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ShowRecords(
                          quickReflexController: _quickController,
                        );
                      },
                    ));
                  },
                  color: Colors.amber,
                  child: const Text("Recordes"),
                )
              ],
            ),
          ),
          Observer(
            builder: (context) {
              return _quickController.isClickPlay
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 48, horizontal: 24),
                      child: PrePlay(
                        quickReflexController: _quickController,
                      ),
                    )
                  : const SizedBox();
            },
          )
        ]),
      ),
    );
  }
}

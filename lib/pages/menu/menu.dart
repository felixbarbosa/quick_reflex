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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: SafeArea(
          child: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Color.fromARGB(255, 83, 83, 83),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Quick Reflex",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 45,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                    width: 280,
                    child: MaterialButton(
                      onPressed: () => _quickController.setClickPlay(true),
                      color: const Color.fromARGB(255, 255, 218, 106),
                      child: const Text("Jogar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                              color: Color.fromARGB(255, 141, 119, 53))),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 280,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ShowRecords(
                              quickReflexController: _quickController,
                            );
                          },
                        ));
                      },
                      color: const Color.fromARGB(255, 255, 218, 106),
                      child: const Text("Recordes",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                              color: Color.fromARGB(255, 141, 119, 53))),
                    ),
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
      ),
    );
  }
}

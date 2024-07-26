import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quick_reflex/model/quick_reflex.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Home extends StatefulWidget {
  final QuickReflex quickReflex;
  const Home({super.key, required this.quickReflex});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _left = 0;
  double _top = 0;
  bool _buttonPress = false;
  bool _isFinishTime = false;
  final Random _random = Random();
  Color _buttonColor = Colors.black;
  int _totalDisplayTime = 0;
  late StopWatchTimer _stopWatchTimer;
  double _pressTime = 0;
  final List<double> _listPressTimes = [];
  bool _isStarting = false;
  int _startCountdown = 3;
  late QuickReflex _quickReflex;
  final int _timeMaxInvisible = 4000;
  int _timeMinInvisible = 1000;
  int _timeVisible = 5000;

  @override
  void initState() {
    _quickReflex = widget.quickReflex;
    _setVelocity();
    //Quando completar o _initCount chama o _showCircle
    _initCount().whenComplete(() => _showCircle());
    super.initState();
  }

  _setVelocity() {
    if (_quickReflex.dificuldade.name == "iniciante") {
      //4850 - 3500
      //Diminuir a velocidade de 150 em 150 a cada numero

      _timeVisible = 5000 - (_quickReflex.velocidade * 150);
      _timeMinInvisible = 2600;
    } else if (_quickReflex.dificuldade.name == "intermediario") {
      //3350 - 2000
      //Diminuir a velocidade de 150 em 150 a cada numero

      _timeVisible = 3500 - (_quickReflex.velocidade * 150);
      _timeMinInvisible = 1800;
    } else if (_quickReflex.dificuldade.name == "avancado") {
      //1850 - 500
      //Diminuir a velocidade de 150 em 150 a cada numero

      _timeVisible = 2000 - (_quickReflex.velocidade * 150);
      _timeMinInvisible = 1000;
    } else {
      //455 - 50
      //Diminuir a velocidade de 45 em 45 a cada numero

      _timeVisible = 500 - (_quickReflex.velocidade * 45);
      _timeMinInvisible = 200;
    }
  }

  Future<void> _initCount() async {
    setState(() {
      _isStarting = true;
    });

    Timer timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_startCountdown == 0) {
          setState(() {
            _isStarting = false;
          });
          timer.cancel();
        } else {
          setState(() {
            _startCountdown--;
          });
        }
      },
    );

    while (timer.isActive) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }

  _calculateFinalResult() async {
    double hitPercent = (100 * _listPressTimes.length) / _totalDisplayTime;
    double sumTotalReaction = 0;
    await Future.wait(_listPressTimes.map((e) async {
      sumTotalReaction = sumTotalReaction + e;
    }));
    double averageReaction = sumTotalReaction / _listPressTimes.length;

    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terminou o tempo!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Você acertou ${_listPressTimes.length} de $_totalDisplayTime (${hitPercent.toStringAsFixed(2)}%)'),
                _listPressTimes.isEmpty
                    ? const SizedBox()
                    : Text(
                        'Sua média de tempo de reação foi: ${averageReaction.toStringAsFixed(3)} segundos.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCircle() async {
    //Inicializar o cronometro
    _initTime();

    //Tempo para aparecer a primeira bolinha
    await Future.delayed(Duration(milliseconds: _random.nextInt(4000) + 1000));
    await Future.doWhile(() async {
      if (_isFinishTime) {
        await _calculateFinalResult();

        return false;
      } else {
        //Mostrar a bolinha na cor verde em determinada posição da tela
        setState(() {
          _buttonColor = const Color.fromARGB(255, 0, 255, 8);
          _left = _random.nextDouble();
          _top = _random.nextDouble();
        });

        //Acrescenta 1 todas as vezes que a bolinha aparecer na tela
        _totalDisplayTime++;

        //Tempo que a bolinha fica na tela e esperar o toque do usuario
        await _listenTouch();

        //Fazer a bolinha sumir
        setState(() {
          _buttonColor = Colors.black;
        });
      }
      //Tempo que a bolinha fica sumida
      await Future.delayed(Duration(
          milliseconds:
              _random.nextInt(_timeMaxInvisible) + _timeMinInvisible));
      return true;
    });
  }

  _initTime() async {
    await Future.delayed(const Duration(minutes: 1));
    _isFinishTime = true;
  }

  _listenTouch() async {
    _stopWatchTimer = StopWatchTimer(
        mode: StopWatchMode.countDown, presetMillisecond: _timeVisible);

    _stopWatchTimer.onStartTimer();

    _stopWatchTimer.rawTime.listen((value) async {
      _pressTime = (_timeVisible - value) / 1000;

      if (_buttonPress && _stopWatchTimer.isRunning) {
        print('press time $_pressTime');
        _listPressTimes.add(_pressTime);
        _buttonPress = false;
        _stopWatchTimer.onStopTimer();
      }
    });

    while (_stopWatchTimer.isRunning) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        SafeArea(
          child: LayoutBuilder(builder: (contextContainer, constraints) {
            return Container(
              color: Colors.black,
              child: Stack(children: [
                Positioned(
                  left: _left * (constraints.maxWidth - 40),
                  top: _top * (constraints.maxHeight - 40),
                  child: GestureDetector(
                    onTap: () {
                      _buttonPress = true;
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _buttonColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            );
          }),
        ),
        _isStarting
            ? Container(
                color: Colors.black12,
                child: Center(
                  child: Text(
                    "${_startCountdown == 0 ? "GO!" : _startCountdown}",
                    style: const TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ),
              )
            : const SizedBox()
      ]),
    );
  }
}

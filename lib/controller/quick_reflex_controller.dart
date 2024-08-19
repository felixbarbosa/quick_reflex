import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quick_reflex/enum/dificuldade.dart';
import 'package:quick_reflex/model/recorde.dart';
import 'package:sqflite/sqflite.dart';
part 'quick_reflex_controller.g.dart';

class QuickReflexController = QuickReflexControllerBase
    with _$QuickReflexController;

abstract class QuickReflexControllerBase with Store {
  @observable
  bool dificultSelected = false;

  @observable
  bool isClickPlay = false;

  @observable
  bool isLoading = false;

  @observable
  int velocitySelected = 0;

  @observable
  List<Recorde> recordes = [];

  @action
  Future<void> setClickPlay(bool value) async {
    isClickPlay = value;
  }

  @action
  Future<void> setIsLoading(bool value) async {
    isLoading = value;
  }

  @action
  Future<void> setDificultSelected(bool value) async {
    dificultSelected = value;
  }

  @action
  Future<void> setVelocitySelected(int value) async {
    velocitySelected = value;
  }

  Future<Database> openMyDatabase() async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = "${dbPath.path}/quick_reflex.db";
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute('''
          CREATE TABLE recorde (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            playerName TEXT NOT NULL,
            hitPercentage DOUBLE NOT NULL,
            averageTime DOUBLE NOT NULL,
            velocity INTEGER NOT NULL,
            difficulty TEXT NOT NULL
          )
          ''');
      },
    );
    return database;
  }

  insertDatasInTable(Recorde recorde) async {
    isLoading = true;
    final db = await openMyDatabase();
    await db.insert(
      'recorde',
      {
        'playerName': recorde.playerName,
        'hitPercentage': recorde.hitPercentage,
        'averageTime': recorde.averageTime,
        'velocity': recorde.velocity,
        'difficulty': recorde.difficulty.name
      },
    );
    isLoading = false;
  }

  Future<List<Recorde>> readDatasOfTable() async {
    isLoading = true;
    final db = await openMyDatabase();
    recordes.clear();
    List<Map> rows = await db.rawQuery('SELECT * FROM recorde');

    await Future.wait(rows.map((e) async {
      recordes.add(Recorde(
          playerName: e["playerName"],
          difficulty: Dificuldade.values
              .firstWhere((element) => element.name == e["difficulty"]),
          hitPercentage: e["hitPercentage"],
          averageTime: e["averageTime"],
          velocity: e["velocity"]));
    }));

    isLoading = false;

    return recordes;
  }
}

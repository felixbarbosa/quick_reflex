import 'package:mobx/mobx.dart';
part 'quick_reflex_controller.g.dart';

class QuickReflexController = QuickReflexControllerBase
    with _$QuickReflexController;

abstract class QuickReflexControllerBase with Store {
  @observable
  bool dificultSelected = false;

  @observable
  bool isClickPlay = false;

  @observable
  int velocitySelected = 0;

  @action
  Future<void> setClickPlay(bool value) async {
    isClickPlay = value;
  }

  @action
  Future<void> setDificultSelected(bool value) async {
    dificultSelected = value;
  }

  @action
  Future<void> setVelocitySelected(int value) async {
    velocitySelected = value;
  }
}

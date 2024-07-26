// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_reflex_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuickReflexController on QuickReflexControllerBase, Store {
  late final _$dificultSelectedAtom = Atom(
      name: 'QuickReflexControllerBase.dificultSelected', context: context);

  @override
  bool get dificultSelected {
    _$dificultSelectedAtom.reportRead();
    return super.dificultSelected;
  }

  @override
  set dificultSelected(bool value) {
    _$dificultSelectedAtom.reportWrite(value, super.dificultSelected, () {
      super.dificultSelected = value;
    });
  }

  late final _$isClickPlayAtom =
      Atom(name: 'QuickReflexControllerBase.isClickPlay', context: context);

  @override
  bool get isClickPlay {
    _$isClickPlayAtom.reportRead();
    return super.isClickPlay;
  }

  @override
  set isClickPlay(bool value) {
    _$isClickPlayAtom.reportWrite(value, super.isClickPlay, () {
      super.isClickPlay = value;
    });
  }

  late final _$velocitySelectedAtom = Atom(
      name: 'QuickReflexControllerBase.velocitySelected', context: context);

  @override
  int get velocitySelected {
    _$velocitySelectedAtom.reportRead();
    return super.velocitySelected;
  }

  @override
  set velocitySelected(int value) {
    _$velocitySelectedAtom.reportWrite(value, super.velocitySelected, () {
      super.velocitySelected = value;
    });
  }

  late final _$setClickPlayAsyncAction =
      AsyncAction('QuickReflexControllerBase.setClickPlay', context: context);

  @override
  Future<void> setClickPlay(bool value) {
    return _$setClickPlayAsyncAction.run(() => super.setClickPlay(value));
  }

  late final _$setDificultSelectedAsyncAction = AsyncAction(
      'QuickReflexControllerBase.setDificultSelected',
      context: context);

  @override
  Future<void> setDificultSelected(bool value) {
    return _$setDificultSelectedAsyncAction
        .run(() => super.setDificultSelected(value));
  }

  late final _$setVelocitySelectedAsyncAction = AsyncAction(
      'QuickReflexControllerBase.setVelocitySelected',
      context: context);

  @override
  Future<void> setVelocitySelected(int value) {
    return _$setVelocitySelectedAsyncAction
        .run(() => super.setVelocitySelected(value));
  }

  @override
  String toString() {
    return '''
dificultSelected: ${dificultSelected},
isClickPlay: ${isClickPlay},
velocitySelected: ${velocitySelected}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TipoController on _TipoControllerBase, Store {
  final _$listTiposAtom = Atom(name: '_TipoControllerBase.listTipos');

  @override
  List<String> get listTipos {
    _$listTiposAtom.reportRead();
    return super.listTipos;
  }

  @override
  set listTipos(List<String> value) {
    _$listTiposAtom.reportWrite(value, super.listTipos, () {
      super.listTipos = value;
    });
  }

  final _$listTipos2Atom = Atom(name: '_TipoControllerBase.listTipos2');

  @override
  List<String> get listTipos2 {
    _$listTipos2Atom.reportRead();
    return super.listTipos2;
  }

  @override
  set listTipos2(List<String> value) {
    _$listTipos2Atom.reportWrite(value, super.listTipos2, () {
      super.listTipos2 = value;
    });
  }

  final _$dropdownValueAtom = Atom(name: '_TipoControllerBase.dropdownValue');

  @override
  String get dropdownValue {
    _$dropdownValueAtom.reportRead();
    return super.dropdownValue;
  }

  @override
  set dropdownValue(String value) {
    _$dropdownValueAtom.reportWrite(value, super.dropdownValue, () {
      super.dropdownValue = value;
    });
  }

  final _$_TipoControllerBaseActionController =
      ActionController(name: '_TipoControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_TipoControllerBaseActionController.startAction(
        name: '_TipoControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_TipoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listTipos: ${listTipos},
listTipos2: ${listTipos2},
dropdownValue: ${dropdownValue}
    ''';
  }
}

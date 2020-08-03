import 'projeto_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class DadosProjetoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ProjetoController()),
      ];

  @override
  List<Router> get routers => [];

  static Inject get to => Inject<DadosProjetoModule>.of();
}
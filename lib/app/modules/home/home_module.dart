import 'package:flutter/material.dart';
import 'package:orcamento_mestre/app/modules/dadosEmpresa/empresa_controller.dart';
import 'package:orcamento_mestre/app/modules/dadosFreelancer/freelancer_controller.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class HomeModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => EmpresaController()),
        Bind((i) => FreelancerController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();

  @override
  Widget get view => HomePage();
}

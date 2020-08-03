import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:orcamento_mestre/app/modules/orcamento/orcamento_controller.dart';
import 'package:provider/provider.dart';
import 'empresa_controller.dart';
import 'dart:io';

class DadosEmpresaPage extends StatefulWidget {
  final String title;

  const DadosEmpresaPage({Key key, this.title = "DadosEmpresa"})
      : super(key: key);

  @override
  _DadosEmpresaPageState createState() => _DadosEmpresaPageState();
}

class _DadosEmpresaPageState
    extends ModularState<DadosEmpresaPage, EmpresaController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    final oController = Provider.of<OrcamentoController>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                height: height * .28,
                width: width,
                margin: EdgeInsets.only(
                  top: height * .07,
                ),
                decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Center(
                  child: Row(
                    children: [
                      Observer(builder: (_) {
                        return GestureDetector(
                          onTap: () async {
                            var image = await controller.getImage();
                            image = oController.logo;
                          },
                          child: (controller.logoStatus)
                              ? (kIsWeb)
                                  ? Image.network(controller.imageFile.path)
                                  : Image.file(File(controller.imageFile.path))
                              : Container(
                                  height: height * .15,
                                  width: width * .15,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  margin: EdgeInsets.only(left: width * .02),
                                  child: Center(
                                    child: (controller.logoStatus)
                                        ? (kIsWeb)
                                            ? Image.network(
                                                controller.imageFile.path,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(controller.imageFile.path),
                                                fit: BoxFit.cover,
                                              )
                                        : Text(
                                            'Adicione sua Logo aqui',
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  ),
                                ),
                        );
                      }),
                      Container(
                        height: height * .06,
                        width: width * .35,
                        margin: EdgeInsets.only(
                          left: width * .012,
                        ),
                        child: TextFormField(
                          controller: controller.nameEmpresa,
                          onChanged: (newName) {
                            oController.nomeEmpresa = newName;
                          },
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            labelText: "Nome",
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(12.0)),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          validator: (text) {
                            if (text.isEmpty) return "O campo nome, está vazio";
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: height * .56,
                width: width,
                margin: EdgeInsets.only(top: height * .005),
                decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orcamento_mestre/app/modules/dadosProjeto/projeto_controller.dart';
import 'package:orcamento_mestre/app/modules/orcamento/orcamento_controller.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class ItemDescritionWidget extends StatefulWidget {
  @override
  _ItemDescritionWidgetState createState() => _ItemDescritionWidgetState();
}

class _ItemDescritionWidgetState extends State<ItemDescritionWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProjetoController>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    final format = DateFormat("HH:mm");
    final initialValue = DateTime.now();
    DateTime value = DateTime.now();
    final oController = Provider.of<OrcamentoController>(context);
    return Container(
        height: height * 0.16,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black.withAlpha(70),
                  offset: const Offset(3.0, 10.0),
                  blurRadius: 15.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: height * .06,
                    width: width * .32,
                    child: Center(
                      child: TextFormField(
                        controller: controller.itemController,
                        onChanged: controller.changeDescricao,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          labelText: "Descrição do Ítem",
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(12.0)),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        validator: (text) {
                          if (text.isEmpty)
                            return "O campo Descrição do ítem está vazio!";
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: height * .06,
                    width: width * .13,
                    margin: EdgeInsets.only(left: width * .005),
                    child: Center(
                      child: TextFormField(
                        controller: controller.valorController,
                        onChanged: controller.setValor,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          labelText: "R\$ 0.000,00",
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(12.0)),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        validator: (text) {
                          if (text.isEmpty) return "O campo Valor está vazio!";
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: height * .06,
                    width: width * .32,
                    decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Center(
                        child: Text(
                      'Estimativa de tempo de execução',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )),
                  ),
                  Container(
                      height: height * .06,
                      width: width * .13,
                      margin: EdgeInsets.only(left: width * .005),
                      child: Center(
                          child: DateTimeField(
                        controller: controller.tempoController,
                        format: format,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          labelText: "Tempo",
                          labelStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(12.0)),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onChanged: (time) => controller.changeTempo,
                        onShowPicker: (context, currentValue) async {
                          final date = DateTime.now();
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          controller
                              .changeTempo(DateTimeField.combine(date, time));
                          return DateTimeField.convert(time);
                        },
                      ))),
                ],
              ),
            ],
          ),
        ));
  }
}

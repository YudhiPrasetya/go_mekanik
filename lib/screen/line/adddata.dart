import 'package:flutter/material.dart';
import 'package:go_mekanik/model/Line.dart';
import 'package:go_mekanik/service/line_service.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerOperators = TextEditingController();
  TextEditingController controllerShift = TextEditingController();
  TextEditingController controllerHead = TextEditingController();
  TextEditingController controllerIdSpv = TextEditingController();
  TextEditingController controllerFloor = TextEditingController();

  void addData() {
    ApiService apiService = ApiService();

    Line line = Line(
        name: controllerName.text,
        description: controllerDescription.text,
        shift: controllerShift.text,
        operators: controllerOperators.text,
        head: controllerHead.text,
        id_spv: controllerIdSpv.text,
        floor: controllerFloor.text);

    apiService.createLine(line);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Column(children: [
              TextField(
                controller: controllerName,
                decoration: const InputDecoration(
                    hintText: "Name Of Line", labelText: "Line Name"),
              ),
              TextField(
                controller: controllerDescription,
                decoration: const InputDecoration(
                    hintText: "Description of the line",
                    labelText: "Description"),
              ),
              TextField(
                controller: controllerShift,
                decoration: const InputDecoration(
                    hintText: "Line Shift", labelText: "Shift"),
              ),
              TextField(
                controller: controllerOperators,
                decoration: const InputDecoration(
                    hintText: "Number of line operators",
                    labelText: "Operator"),
              ),
              TextField(
                controller: controllerHead,
                decoration: const InputDecoration(
                    hintText: "Head Of Line", labelText: "Head"),
              ),
              TextField(
                controller: controllerIdSpv,
                decoration: const InputDecoration(
                    hintText: "ID Supervisor", labelText: "Id SPV"),
              ),
              TextField(
                controller: controllerFloor,
                decoration: const InputDecoration(
                    hintText: "Floor position line", labelText: "Floor"),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
              // ignore: deprecated_member_use
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent)),
                  child: const Text('Add Data'),
                  // color: Colors.blueAccent,
                  onPressed: () {
                    addData();
                    Navigator.pop(context);
                  })
            ]),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_mekanik/model/Line.dart';
import 'package:go_mekanik/service/line_service.dart';
import 'package:go_mekanik/screen/line/line_list.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  const EditData({super.key, required this.list, required this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController? controllerName;
  TextEditingController? controllerDescription;
  TextEditingController? controllerOperators;
  TextEditingController? controllerShift;
  TextEditingController? controllerHead;
  TextEditingController? controllerIdSpv;
  TextEditingController? controllerFloor;

  void editData() {
    ApiService apiService = ApiService();
    Line line = Line(
        name: controllerName!.text,
        description: controllerDescription!.text,
        shift: controllerShift!.text,
        operators: controllerOperators!.text,
        head: controllerHead!.text,
        id_spv: controllerIdSpv!.text,
        floor: controllerFloor!.text);
    apiService.updateLine(id: widget.list[widget.index]['id_line'], line: line);
  }

  @override
  void initState() {
    controllerName =
        TextEditingController(text: widget.list[widget.index]['name']);

    controllerDescription =
        TextEditingController(text: widget.list[widget.index]['description']);

    controllerOperators =
        TextEditingController(text: widget.list[widget.index]['operators']);

    controllerShift =
        TextEditingController(text: widget.list[widget.index]['shift']);

    controllerHead =
        TextEditingController(text: widget.list[widget.index]['head']);

    controllerIdSpv =
        TextEditingController(text: widget.list[widget.index]['id_spv']);

    controllerFloor =
        TextEditingController(text: widget.list[widget.index]['floor']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EDIT DATA"),
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
                  child: const Text('Update Data'),
                  onPressed: () {
                    editData();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Home()));
                  })
            ]),
          ],
        ),
      ),
    );
  }
}

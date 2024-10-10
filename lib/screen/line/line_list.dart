import 'package:flutter/material.dart';
import 'package:go_mekanik/service/line_service.dart';
// import 'package:go_mekanik/util/capitalize.dart';
import 'package:go_mekanik/screen/line/adddata.dart';
import 'package:go_mekanik/screen/line/editdata.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ApiService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Line"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const AddData(),
        )),
      ),
      body: FutureBuilder<List>(
        future: apiService?.getLines(),
        builder: (context, snapshot) {
          // if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(list: snapshot.data!)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    Detail(list: list, index: i))),
            child: Card(
              child: ListTile(
                title: Text(list[i]['name']),
                leading: const Icon(Icons.people),
                subtitle: Text(list[i]['floor']),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Detail extends StatefulWidget {
  final List list;
  final int index;
  const Detail({super.key, required this.index, required this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    ApiService apiService = ApiService();

    apiService.deleteLine(id: "${widget.list[widget.index]['id_line']}");
  }

  void confirm() {
    // ignore: unused_local_variable
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Are You Sure Want To Delete '${widget.list[widget.index]['name']}' ?"),
      actions: [
        // ignore: deprecated_member_use
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            child: const Text('OK DELETE!'),
            // color: Colors.red,
            onPressed: () {
              deleteData();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const Home(),
              ));
            }),
        // ignore: deprecated_member_use
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
          child: const Text('CANCEL!'),
          // color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    // showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.list[widget.index]['name']}"),
        ),
        body: Container(
          height: 250,
          padding: const EdgeInsets.all(20.0),
          child: Card(
              child: Center(
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                Text(
                  widget.list[widget.index]['name'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Description: ${widget.list[widget.index]['description']}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Operators: ${widget.list[widget.index]['operators']}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ignore: deprecated_member_use
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green)),
                      child: const Text("EDIT"),
                      // color: Colors.green,
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EditData(list: widget.list, index: widget.index),
                      )),
                    ),
                    // ignore: deprecated_member_use
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      child: const Text("DELETE"),
                      // color: Colors.red,
                      onPressed: () => confirm(),
                    ),
                  ],
                )
              ],
            ),
          )),
        ));
  }
}

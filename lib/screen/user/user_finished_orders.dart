// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/machineSettledBloc.dart';
import 'package:go_mekanik/model/userFinishedOrdersDetail.dart';
import 'package:intl/intl.dart';

class UserFinishedOrdersView extends StatefulWidget {
  final String? idUserMekanik;
  final String? month;
  final String? year;
  final String? userName;
  final String? totalPoint;

  const UserFinishedOrdersView(
      {Key? key,
      this.idUserMekanik,
      this.month,
      this.year,
      this.userName,
      this.totalPoint})
      : super(key: key);

  @override
  _UserFinishedOrdersViewState createState() => _UserFinishedOrdersViewState();
}

class _UserFinishedOrdersViewState extends State<UserFinishedOrdersView> {
  final controller = ScrollController();
  double offset = 0;
  Future<List<UserOrdersFinishedDetail>>? _func;
  final dateFormat = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    _getData();
    controller.addListener(onScroll);
    super.initState();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _getData() {
    _func = machineSettledBloc.getUserOrdersFinishedDetail(
        widget.idUserMekanik.toString(),
        widget.month.toString(),
        widget.year.toString()) as Future<List<UserOrdersFinishedDetail>>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("List of Finished Orders"),
            backgroundColor: Colors.purple),
        body: FutureBuilder<List<UserOrdersFinishedDetail>>(
          future: _func,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              List<UserOrdersFinishedDetail> data = snapshot.data!;
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,

                        // height: MediaQuery.of(context).size.height,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xff5a348b),
                            gradient: const LinearGradient(
                                colors: [Color(0xffebac38), Color(0xffde4d2a)],
                                begin: Alignment.centerRight,
                                end: Alignment(-1.0, -1.0))),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 4.0),
                              child: Text(
                                'List of Finished Orders',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              widget.userName!,
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 15.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                width: 100.0,
                                height: 80.0,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        '${widget.totalPoint}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            color: Color(0xff8d70fe),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: const Text(
                                        'points',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Color(0xff8d70fe)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 500,
                              child: InteractiveViewer(
                                constrained: false,

                                // scrollDirection: Axis.horizontal,

                                child: DataTable(
                                  sortColumnIndex: 0,
                                  sortAscending: false,
                                  showBottomBorder: true,
                                  columns: const [
                                    DataColumn(
                                        label: Text(
                                          'Date',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        tooltip: 'Date'),
                                    DataColumn(
                                        label: Text(
                                          'Brand',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        tooltip: 'Sewing Machine Brand'),
                                    DataColumn(
                                        label: Text(
                                          'Machine Type',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        tooltip: 'Sewing Machine Type'),
                                    DataColumn(
                                        label: Text(
                                          'Machine SN',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        tooltip:
                                            'Sewing Machine Serial Number'),
                                    DataColumn(
                                        label: Text(
                                          'Symptom',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        tooltip: 'Sewing Machine Symptom'),
                                    DataColumn(
                                        label: Text(
                                          'Duration',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        tooltip: 'Duration of finished order'),
                                  ],
                                  rows: data
                                      .map((e) => DataRow(cells: [
                                            DataCell(Container(
                                              child: Text(
                                                dateFormat.format(e.date!),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                            )),
                                            DataCell(Container(
                                              child: Text(
                                                (e.machineBrand ?? "-"),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                            )),
                                            DataCell(Container(
                                              child: Text(
                                                (e.machineType ?? "-"),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                            )),
                                            DataCell(Container(
                                              child: Text(
                                                (e.machineSn ?? "-"),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                            )),
                                            DataCell(Container(
                                              child: Text(
                                                e.sympton!,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                            )),
                                            DataCell(Container(
                                              child: Text(
                                                e.duration.toString(),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                            )),
                                          ]))
                                      .toList(),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10.0),
                            //   child: RaisedButton(
                            //     onPressed: () {
                            //       Navigator.pop(context);
                            //     },
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(30.0)),
                            //     child: Text(
                            //       'OK',
                            //       style: TextStyle(color: Color(0xff6200ee)),
                            //     ),
                            //   ),
                            // )
                          ],
                        )),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));

    // return Scaffold(
    //   appBar: AppBar(title: Text('List of Finished Orders'), backgroundColor: Colors.purple,),

    // );
  }
}

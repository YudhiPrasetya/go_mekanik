// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/mekanikRepairingBloc.dart';
import 'package:go_mekanik/model/userCanceledOrdersDetail.dart';
import 'package:intl/intl.dart';

class UserCanceledOrdersView extends StatefulWidget {
  final String? idUserMekanik;
  final String? month;
  final String? year;
  final String? userName;

  const UserCanceledOrdersView(
      {Key? key, this.idUserMekanik, this.month, this.year, this.userName})
      : super(key: key);

  @override
  _UserCanceledOrdersViewState createState() => _UserCanceledOrdersViewState();
}

class _UserCanceledOrdersViewState extends State<UserCanceledOrdersView> {
  final controller = ScrollController();
  double offset = 0;
  Future<List<UserCanceledOrdersDetail>>? _func;
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
    // final rsUserFinishedOrderDetail = await machineSettledBloc
    //     .getUserOrdersFinishedDetail(widget.idUserMekanik, widget.month);

    // setState(() {
    //   dsUserFinishedOrdersDetail = rsUserFinishedOrderDetail;
    // });

    // dsUserFinishedOrdersDetail.forEach((d) => {print(d.machine_type)});

    // print('dsUserFinishedOrdersDetail.machine_sn: $dsUserFinishedOrdersDetail');

    _func = mekanikRepairingBloc.userCanceledOrdersDetail(
        widget.idUserMekanik.toString(),
        widget.month.toString(),
        widget.year.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("List of Finished Orders"),
            backgroundColor: Colors.purple),
        body: FutureBuilder<List<UserCanceledOrdersDetail>>(
          future: _func,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              List<UserCanceledOrdersDetail> data = snapshot.data!;
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
                                colors: [Color(0xffcb3a57), Color(0xffcb3a57)],
                                begin: Alignment.centerRight,
                                end: Alignment(-1.0, -1.0))),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 4.0),
                              child: Text(
                                'List of Canceled Orders',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              widget.userName.toString(),
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 15.0),
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
                                          'Symtomp',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        tooltip: 'Sewing Machine Symtomp'),
                                  ],
                                  rows: data
                                      .map((e) => DataRow(cells: [
                                            DataCell(Text(
                                              dateFormat.format(e.tgl!),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            )),
                                            DataCell(Text(
                                              e.machineBrand.toString(),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            )),
                                            DataCell(Text(
                                              e.machineType.toString(),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            )),
                                            DataCell(Text(
                                              e.machineSN.toString(),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            )),
                                            DataCell(Text(
                                              e.symptomp.toString(),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0,
                                                  color: Colors.white),
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

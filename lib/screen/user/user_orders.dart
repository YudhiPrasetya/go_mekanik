// import 'dart:html';

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/mekanikRepairingBloc.dart';
import 'package:go_mekanik/model/userOrdersDetail.dart';
import 'package:intl/intl.dart';

class UserOrdersView extends StatefulWidget {
  final String? idUserMekanik;
  final String? month;
  final String? year;
  final String? userName;
  final int? totalPoint;

  const UserOrdersView(
      {Key? key,
      this.idUserMekanik,
      this.month,
      this.year,
      this.userName,
      this.totalPoint})
      : super(key: key);

  @override
  _UserOrdersViewState createState() => _UserOrdersViewState();
}

class _UserOrdersViewState extends State<UserOrdersView> {
  final controller = ScrollController();
  double offset = 0;
  Future<List<UserOrdersDetail>>? _func;

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
    _func = mekanikRepairingBloc.userOrdersDetail(
        widget.idUserMekanik!, widget.month!, widget.year!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List of Orders",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<List<UserOrdersDetail>>(
        future: _func,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<UserOrdersDetail> data = snapshot.data!;
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
                              colors: [Color(0xff8d70fe), Color(0xff2da9ef)],
                              begin: Alignment.centerRight,
                              end: Alignment(-1.0, -1.0))),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 4.0),
                            child: Text(
                              'List of Orders',
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
                                  shape: BoxShape.circle, color: Colors.white),
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
                                columns: [
                                  const DataColumn(
                                      label: Text(
                                        'Date',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                      tooltip: 'Date'),
                                  const DataColumn(
                                      label: Text(
                                        'Brand',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                      tooltip: 'Sewing Machine Brand'),
                                  const DataColumn(
                                      label: Text(
                                        'Machine Type',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                      tooltip: 'Sewing Machine Type'),
                                  const DataColumn(
                                      label: Text(
                                        'Machine SN',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                      tooltip: 'Sewing Machine Serial Number'),
                                  const DataColumn(
                                      label: Text(
                                        'Symptom',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                      tooltip: 'Sewing Machine Symtomp'),
                                ],
                                rows: data
                                    .map((e) => DataRow(cells: [
                                          DataCell(Container(
                                            child: Text(
                                              dateFormat.format(e.tgl!),
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
                                              (e.machineSN ?? "-"),
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
                                              (e.symptomp ?? "-"),
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
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(title: Text('List of Finished Orders'), backgroundColor: Colors.purple,),

    // );
  }
}

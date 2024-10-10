// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_mekanik/bloc/orderBloc.dart';
import 'package:go_mekanik/components/list_machine_breakdown_status.dart';
// import 'package:go_mekanik/components/machine_breakdown_tile.dart';
import 'package:go_mekanik/model/orderModel.dart';
import 'package:go_mekanik/screen/machines_breakdown/home_page.dart';
// import 'package:go_mekanik/util/SessionManager.dart';

class MachinesBreakdownPage extends StatefulWidget {
  final String? idUser;
  const MachinesBreakdownPage({super.key, required this.idUser});

  @override
  State<MachinesBreakdownPage> createState() => _MachinesBreakdownPageState();
}

class _MachinesBreakdownPageState extends State<MachinesBreakdownPage> {
  String? idUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _streamBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        idUser: widget.idUser,
                      )),
              (route) => false);
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.red,
      ),
    );
  }

  _streamBuilder() {
    return StreamBuilder(
        stream: orderBloc.countOrderByIdUser,
        builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _buildListMB(snapshot);
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        });
  }

  Widget _buildListMB(AsyncSnapshot<List<OrderModel>> snapshot) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 10.0, childAspectRatio: 0.85),
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final data = snapshot.data?[index];
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 300),
          child: SlideAnimation(
            verticalOffset: 30.0,
            child: FadeInAnimation(
              child: ListMachineBreakdownStatus(
                idMachineBreakdown: data?.idMachineBreakdown,
                machineBrand: data?.machineBrand,
                machineType: data?.machineType,
                type: data?.type,
                machineSN: data?.machineSN,
                sympton: data?.sympton,
                line: data?.line,
                status: data?.status,
                dateStartWaiting: data?.dateStartWaiting,
                barcode_machine: data?.barcodeMachine,
                idUser: widget.idUser,
              ),
            ),
          ),
        );
      },
    );
  }
}

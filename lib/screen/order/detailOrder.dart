import 'package:flutter/material.dart';
import 'package:go_mekanik/screen/widget/order/ambilOrderButton.dart';
import 'package:go_mekanik/screen/widget/order/appBarDetail.dart';
import 'package:go_mekanik/screen/widget/order/headerDetail.dart';
import 'package:go_mekanik/screen/widget/order/sympton.dart';

class DetailOrder extends StatefulWidget {
  final String? idMachineBreakdown;
  final String? status;
  final String? line;
  final String? machineBrand;
  final String? machineType;
  final String? type;
  final String? machineSN;
  final String? sympton;

  const DetailOrder({
    Key? key,
    this.idMachineBreakdown,
    this.status,
    this.line,
    this.machineBrand,
    this.machineType,
    this.type,
    this.machineSN,
    this.sympton,
  }) : super(key: key);

  @override
  _DetailOrderState createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  int numQty = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue[800],
      appBar: AppBarDetail(context),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 220.0),
                  padding: EdgeInsets.only(top: size.height * 0.12, left: 20.0),
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0))),
                  child: Column(
                    children: [
                      Sympton(sympton: widget.sympton.toString()),
                      const SizedBox(
                        height: 10.0,
                      ),
                      AmbilOrderButton(
                          idMachineBreakdown: widget.idMachineBreakdown!)
                    ],
                  ),
                ),
                HeaderDetail(
                  idMachineBreakdown: widget.idMachineBreakdown,
                  status: widget.status,
                  line: widget.line,
                  machineBrand: widget.machineBrand,
                  machineSN: widget.machineSN,
                  machineType: widget.machineType,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

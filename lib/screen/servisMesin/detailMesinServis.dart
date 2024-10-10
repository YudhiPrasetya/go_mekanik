import 'package:flutter/material.dart';
import 'package:go_mekanik/screen/widget/order/appBarDetail.dart';
import 'package:go_mekanik/screen/widget/servisMesin/ambilServisMesinButton.dart';
import 'package:go_mekanik/screen/widget/servisMesin/headerServisMesinDetail.dart';

class DetailServisMesin extends StatefulWidget {
  final String? idServisMesin;
  final String? tgl;
  final String? idMesin;
  final String? jenis;
  final String? merk;
  final String? tipe;
  final String? noSeri;
  final String? lokasi;
  final String? line;
  final String? status;

  const DetailServisMesin({
    Key? key,
    this.idServisMesin,
    this.tgl,
    this.idMesin,
    this.jenis,
    this.merk,
    this.tipe,
    this.noSeri,
    this.lokasi,
    this.line,
    this.status,
  }) : super(key: key);

  @override
  _DetailServisMesinState createState() => _DetailServisMesinState();
}

class _DetailServisMesinState extends State<DetailServisMesin> {
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
                      // Sympton(sympton: widget.sympton),
                      const SizedBox(
                        height: 10.0,
                      ),
                      AmbilServisMesinButton(
                          idServisMesin: widget.idServisMesin!)
                    ],
                  ),
                ),
                HeaderServisMesinDetail(
                  idServisMesin: widget.idServisMesin,
                  jenis: widget.jenis,
                  line: widget.line,
                  merk: widget.merk,
                  noSeri: widget.noSeri,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

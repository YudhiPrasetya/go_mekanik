import 'package:flutter/material.dart';
import 'package:go_mekanik/screen/widget/order/appBarDetail.dart';
import 'package:go_mekanik/screen/widget/qco/ambilQCOButton.dart';
import 'package:go_mekanik/screen/widget/qco/headerQCODetail.dart';

class DetailQCO extends StatefulWidget {
  final String? idQCODetail;
  final String? tgl;
  final String? style;
  final String? line;
  final String? jenisBarang;
  final String? merk;
  final String? noSeri;
  final String? status;

  const DetailQCO(
      {Key? key,
      this.idQCODetail,
      this.tgl,
      this.style,
      this.line,
      this.jenisBarang,
      this.merk,
      this.noSeri,
      this.status})
      : super(key: key);

  @override
  _DetailQCOState createState() => _DetailQCOState();
}

class _DetailQCOState extends State<DetailQCO> {
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
                      AmbilQCOButton(idQCODetail: widget.idQCODetail!)
                    ],
                  ),
                ),
                HeaderQCODetail(
                  idQCODetail: widget.idQCODetail,
                  jenisBarang: widget.jenisBarang,
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

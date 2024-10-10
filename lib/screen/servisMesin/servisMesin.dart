// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_mekanik/bloc/servisMesinBloc.dart';
import 'package:go_mekanik/model/servisMesinModel.dart';
import 'package:go_mekanik/screen/servisMesin/detailMesinServis.dart';
import 'package:go_mekanik/screen/widget/servisMesin/listServisMesin.dart';
// import 'package:go_mekanik/screen/widget/qco/listServisMesin.dart';

import '../mainNavigation.dart';

class ServisMesin extends StatefulWidget {
  final String? status;

  const ServisMesin({Key? key, this.status}) : super(key: key);

  @override
  _ServisMesinState createState() => _ServisMesinState();
}

class _ServisMesinState extends State<ServisMesin> {
  @override
  void initState() {
    // _getIsMaintenance();
    super.initState();
  }

  // _getIsMaintenance() async {
  //   String idUserMekanik = await SessionManager().getIdUserMekanik();
  //   final res = await mekanikMemberBloc.getMekanikMember(idUserMekanik);
  //   _isMaintenance = int.parse(res['isMaintenance']);
  // }

  @override
  Widget build(BuildContext context) {
    //print('_isMaintenance: $_isMaintenance');
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: Colors.white,
      // body: (_isMaintenance == 1
      //     ? _streamBuilder()
      //     : Center(
      //         child: Text("Maaf, Anda tidak berhak mengambil order ini.",
      //             style: TextStyle(
      //                 color: Colors.red,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 14)),
      //       )),
      body: _streamBuilder(isLandscape),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainNavigation()),
              (route) => false);
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildListServisMesin(
      AsyncSnapshot<List<ServisMesinModel>> snapshot, bool landscape) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (landscape ? 4 : 2),
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.85),
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) {
        final data = snapshot.data![index];
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 500),
          child: SlideAnimation(
            verticalOffset: 30.0,
            child: FadeInAnimation(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailServisMesin(
                                idServisMesin: data.idServisMesin,
                                idMesin: data.idMesin,
                                tgl: data.tgl,
                                jenis: data.jenis,
                                merk: data.merk,
                                tipe: data.tipe,
                                noSeri: data.noSeri,
                                lokasi: data.lokasi,
                                line: data.line,
                                status: data.status,
                              )));
                },
                child: ListServisMesin(
                  idServisMesin: data.idServisMesin,
                  idMesin: data.idMesin,
                  tgl: data.tgl,
                  jenis: data.jenis,
                  merk: data.merk,
                  tipe: data.tipe,
                  noSeri: data.noSeri,
                  lokasi: data.lokasi,
                  line: data.line,
                  status: data.status,
                  startWaiting: data.startWaiting,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _streamBuilder(ls) {
    return StreamBuilder(
      stream: servisMesinBloc.countServisMesin,
      builder: (context, AsyncSnapshot<List<ServisMesinModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data'),
            );
          } else {
            // print(snapshot.data.);
            return _buildListServisMesin(snapshot, ls);
            // updateOrders();
          }
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

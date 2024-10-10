import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_mekanik/bloc/qcoBloc.dart';
import 'package:go_mekanik/model/qcoModel.dart';
import 'package:go_mekanik/screen/qco/detailQCO.dart';
import 'package:go_mekanik/screen/widget/qco/listQCO.dart';

import '../mainNavigation.dart';

class QCO extends StatefulWidget {
  final String? status;

  const QCO({this.status});

  @override
  _QCOState createState() => _QCOState();
}

class _QCOState extends State<QCO> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _streamBuilder(isLandscape),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _streamBuilder();
          // print('button clicked!');
          // print(orderBloc.getOrder('Waiting...'));
          // _resfreshItems();
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

  Widget _buildListQCO(AsyncSnapshot<List<QCOModel>> snapshot, bool landscape) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (landscape ? 4 : 2),
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.85),
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
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
                            builder: (context) => DetailQCO(
                                  idQCODetail: data.idQCODetail,
                                  tgl: data.tgl,
                                  style: data.style,
                                  line: data.line,
                                  jenisBarang: data.jenisBarang,
                                  merk: data.merk,
                                  noSeri: data.noSeri,
                                  status: data.status,
                                )));
                  },
                  child: ListQCO(
                    idQCODetail: data.idQCODetail,
                    tgl: data.tgl,
                    style: data.style,
                    line: data.line,
                    jenisBarang: data.jenisBarang,
                    merk: data.merk,
                    noSeri: data.noSeri,
                    location: data.location,
                    startWaiting: data.startWaiting,
                  )),
            ),
          ),
        );
      },
    );
  }

  _streamBuilder(ls) {
    // final StreamController<List<OrderModel>> _currOrderStreamCtrl =
    //     StreamController<List<OrderModel>>.broadcast();

    // updateOrders() =>
    //     _currOrderStreamCtrl.sink.add(orderBloc.getOrder(widget.status));

    return StreamBuilder(
      stream: qcoBloc.countQCO,
      builder: (context, AsyncSnapshot<List<QCOModel>> snapshot) {
        //print('snapshot.data: ${snapshot.data}');
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data'),
            );
          } else {
            // print(snapshot.data.);
            return _buildListQCO(snapshot, ls);
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

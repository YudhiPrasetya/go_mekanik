import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/orderBloc.dart';
import 'package:go_mekanik/model/orderModel.dart';
import 'package:go_mekanik/screen/mainNavigation.dart';
import 'package:go_mekanik/screen/order/detailOrder.dart';
import 'package:go_mekanik/screen/widget/order/listOrder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Order extends StatefulWidget {
  final String? status;

  const Order({
    super.key,
    this.status,
  });

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _streamBuilder(),
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

  // _resfreshItems() {
  //   orderBloc.getOrder(widget.status);

  // }

  // _listOrder(AsyncSnapshot<List<OrderModel>> snapshot) {
  // AsyncSnapshot<List<OrderModel>> snapshot;
  Widget _buildListOrder(AsyncSnapshot<List<OrderModel>> snapshot) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 10.0, childAspectRatio: 0.85),
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final data = snapshot.data?[index];
        if (kDebugMode) {
          print("data from order: $data");
        }
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
                            builder: (context) => DetailOrder(
                                  idMachineBreakdown: data?.idMachineBreakdown,
                                  line: data?.line,
                                  machineBrand: data?.machineBrand,
                                  machineType: data?.machineType,
                                  machineSN: data?.machineSN,
                                  type: data?.type,
                                  status: data?.status,
                                  sympton: data?.sympton,
                                )));
                  },
                  child: ListOrder(
                    idMachineBreakdown: data?.idMachineBreakdown,
                    machineBrand: data?.machineBrand,
                    machineType: data?.machineType,
                    type: data?.type,
                    machineSN: data?.machineSN,
                    sympton: data?.sympton,
                    line: data?.line,
                    floor: data?.floor,
                    dateStartWaiting: data?.dateStartWaiting,
                    spv: data?.spv,
                    barcode: data?.barcodeMachine,
                  )),
            ),
          ),
        );
      },
    );
  }

  _streamBuilder() {
    // final StreamController<List<OrderModel>> _currOrderStreamCtrl =
    //     StreamController<List<OrderModel>>.broadcast();

    // updateOrders() =>
    //     _currOrderStreamCtrl.sink.add(orderBloc.getOrder(widget.status));

    return StreamBuilder(
      stream: orderBloc.countOrder,
      builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
        // if (snapshot.hasData) {
        //   if (snapshot.data.isEmpty) {
        //     return const Center(
        //       child: Text('No data'),
        //     );
        //   } else {
        //     // print(snapshot.data.);
        //     return _buildListOrder(snapshot);
        //     // updateOrders();
        //   }
        // } else if (snapshot.hasError) {
        //   return Text(snapshot.error.toString());
        // }
        // return const Center(
        //   child: CircularProgressIndicator(),
        // );
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          if (kDebugMode) {
            print("snapshot: $snapshot");
          }
          return _buildListOrder(snapshot);
        } else {
          return const Center(
            child: Text('No Data'),
          );
        }
        // return const Center(
        //   child: CircularProgressIndicator(),
        // );
      },
    );
  }
}

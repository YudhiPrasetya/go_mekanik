import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_mekanik/bloc/orderBloc.dart';
import 'package:go_mekanik/screen/order/order.dart';
import 'package:go_mekanik/util/FadeAnimation.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String status = 'Waiting...';
  FadeAnimation fadeAnimation = const FadeAnimation(
      1.0,
      Text('Orders',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.white)));
  // ScreenTitle screenTitle = ScreenTitle(text: 'Orders',color: Colors.white);
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 1);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    orderBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orderBloc.getOrder(status);
    // var getTabs = _getTabs();
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0.0,
        title: fadeAnimation,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          isScrollable: true,
          labelPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
          unselectedLabelColor: const Color(0xFFCDCDCD),
          onTap: _getTabs,
          tabs: const [
            Tab(
              child: Text(
                // ScreenTitle(color: Colors.grey, text: "Open Orders",)
                'Open Orders',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        toolbarTextStyle: const TextTheme().bodyMedium,
        titleTextStyle: const TextTheme().titleLarge,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Order(
            status: 'Waiting...',
          ),
        ],
      ),
    );
  }

  _getTabs(int value) {
    if (value == 0) {
      setState(() {
        status = 'Waiting...';
      });
    }
  }
}

// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart' as StaggeredGridView;
import 'package:go_mekanik/bloc/authBloc.dart';
import 'package:go_mekanik/bloc/userMekanikBloc.dart';
import 'package:go_mekanik/model/userCanceledOrders.dart';
import 'package:go_mekanik/model/userFinishedOrders.dart';
import 'package:go_mekanik/screen/mainNavigation.dart';
import 'package:go_mekanik/screen/user/user_orders.dart';
import 'package:go_mekanik/screen/user/user_profil.dart';
import 'package:go_mekanik/screen/user/user_profile_picture.dart';
import 'package:go_mekanik/service/baseUrl.dart';
// import 'package:go_mekanik/screen/user/user_profil1.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:go_mekanik/bloc/mekanikRepairingBloc.dart';
import 'package:go_mekanik/bloc/machineSettledBloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:go_mekanik/screen/user/user_finished_orders.dart';
import 'package:go_mekanik/screen/user/user_canceled_orders.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard>
    with SingleTickerProviderStateMixin {
  // AnimationController _animationControler;
  String? idMachineBreakdown;
  String? userName;
  String? bagian;
  String? shift;
  String? idUserMekanik;
  String? nik;
  String? totalUserOrder;
  int totalUserCanceledOrders = 0;
  int totalUserOrdersFinished = 0;
  int totalOrders = 0;
  int canceledOrders = 0;

  int totalPoint = 0;

  // var resUserFinishedOrders;
  // var resUserCanceledOrders;

  dynamic dsUserFinishedOrders;
  dynamic dsUserCanceledOrders;

  DateTime thisDay = DateTime.now();

  static final List<String> monthsDropDownItems = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  static final List<int> yearsDropDownItems = [
    2020,
    2021,
    2022,
    2023,
    2024,
    2025,
    2026,
    2027,
    2028,
    2029,
    2030,
    2031,
    2032,
    2033,
    2034,
    2035,
    2036,
    2037,
    2038,
    2039,
    2040,
    2041,
    2042,
    2043,
    2044,
    2045,
    2046,
    2047,
    2048,
    2049,
    2050
  ];

  String? actualOrdersMonthsDropDown;
  int? actualOrdersYearsDropDown;

  int? actualMonthChartOrders;
  int? actualYearChartOrders;

  // String urlMekanikImages = BaseUrl.baseUrlMekanikImages;
  String url = BaseUrl.baseUrlMekanikImages + "/noimage.jpg";

  _UserDashboardState() {
    actualOrdersMonthsDropDown = monthsDropDownItems[thisDay.month - 1];
    actualOrdersYearsDropDown = thisDay.year;
    actualMonthChartOrders = thisDay.month;
    actualYearChartOrders = thisDay.year;
  }

  @override
  void initState() {
    _getDataOrders();
    super.initState();
    // _animationControler =
    //     AnimationController(vsync: this, duration: Duration(seconds: 1))
    //       ..repeat(reverse: true);
  }

  // @override
  // void dispose() {
  //   _animationControler.dispose();
  //   super.dispose();
  // }

  _getDataOrders() async {
    idUserMekanik = await SessionManager().getIdUser();
    nik = await SessionManager().getNIK();
    // url = BaseUrl.baseUrlMekanikImages + "/$nik.jpg";
    url = BaseUrl.baseUrlMekanikImages + "/noimage.jpg";

    final resp = await userMekanikBloc.getById(idUserMekanik!);
    if (kDebugMode) {
      print(resp[0]);
    }

    final resTotalCanceledOrders =
        await mekanikRepairingBloc.userTotalCanceledOrders(
            idUserMekanik!,
            actualMonthChartOrders.toString(),
            actualYearChartOrders.toString());

    final resTotalFinishedOrders =
        await machineSettledBloc.totalUserOrdersFinished(
            idUserMekanik!,
            actualMonthChartOrders.toString(),
            actualYearChartOrders.toString());

    final resUserCanceledOrders = await mekanikRepairingBloc.userCanceledOrders(
        idUserMekanik!,
        actualMonthChartOrders.toString(),
        actualYearChartOrders.toString());

    final resUserFinishedOrders =
        await machineSettledBloc.getUserOrdersFinished(
            idUserMekanik!,
            actualMonthChartOrders.toString(),
            actualYearChartOrders.toString());

    // resUserFinishedOrders.forEach((m) => {print(m.day)});

    setState(() {
      userName = resp['Nama'];
      bagian = resp['Bagian'];
      shift = resp['Jabatan'];
      totalUserCanceledOrders = resTotalCanceledOrders['data'];
      totalUserOrdersFinished = resTotalFinishedOrders['data'];
      totalOrders = totalUserCanceledOrders + totalUserOrdersFinished;

      totalPoint = totalUserOrdersFinished * 10;

      dsUserFinishedOrders = resUserFinishedOrders;
      dsUserCanceledOrders = resUserCanceledOrders;
    });
  }

  _refreshData() async {
    var resTotalCanceledOrders =
        await mekanikRepairingBloc.userTotalCanceledOrders(
            idUserMekanik!,
            actualMonthChartOrders.toString(),
            actualYearChartOrders.toString());

    var resTotalFinishedOrders =
        await machineSettledBloc.totalUserOrdersFinished(
            idUserMekanik!,
            actualMonthChartOrders.toString(),
            actualYearChartOrders.toString());

    var resUserCanceledOrders = await mekanikRepairingBloc.userCanceledOrders(
        idUserMekanik!,
        actualMonthChartOrders.toString(),
        actualYearChartOrders.toString());

    var resUserFinishedOrders = await machineSettledBloc.getUserOrdersFinished(
        idUserMekanik!,
        actualMonthChartOrders.toString(),
        actualYearChartOrders.toString());

    // resUserFinishedOrders.forEach((m) => {print(m.day)});

    setState(() {
      totalUserCanceledOrders = resTotalCanceledOrders['data'];
      totalUserOrdersFinished = resTotalFinishedOrders['data'];
      totalOrders = totalUserCanceledOrders + totalUserOrdersFinished;

      dsUserFinishedOrders = resUserFinishedOrders;
      dsUserCanceledOrders = resUserCanceledOrders;

      totalPoint = totalUserOrdersFinished * 10;

      // print('totalUserOrdersFinished: $totalUserOrdersFinished');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'GoMekanik GI2 - $userName',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.purple,
          elevation: 2.0,
          actions: [
            IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  _deactiveUser();
                })
          ],
        ),
        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: [
            _buildTile(
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Periode: ",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        // const SizedBox(
                        //   width: 12.0,
                        // ),
                        DropdownButton(
                            isDense: true,
                            value: actualOrdersMonthsDropDown,
                            onChanged: (value) {
                              // print('month: $value');
                              actualOrdersMonthsDropDown = value!;
                              actualMonthChartOrders =
                                  monthsDropDownItems.indexOf(value) + 1;
                              // _getDataFinishedOrdersCharts();
                              _refreshData();
                            },
                            items: monthsDropDownItems.map((String title) {
                              return DropdownMenuItem(
                                  value: title,
                                  child: Text(title,
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0)));
                            }).toList()),
                        // const SizedBox(
                        //   width: 12.0,
                        // ),
                        DropdownButton(
                            isDense: true,
                            value: actualOrdersYearsDropDown,
                            onChanged: (value) {
                              actualOrdersYearsDropDown = value!;
                              actualYearChartOrders = value;
                              // yearsDropDownItems.elementAt(index).indexOf(value).;
                              // _getDataFinishedOrdersCharts();
                              _refreshData();
                            },
                            items: yearsDropDownItems.map((int year) {
                              return DropdownMenuItem(
                                  value: year,
                                  child: Text(year.toString(),
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0)));
                            }).toList()),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Total Orders:',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold)),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: UserOrdersView(
                                          userName: userName,
                                          idUserMekanik: idUserMekanik,
                                          month:
                                              actualMonthChartOrders.toString(),
                                          year:
                                              actualYearChartOrders.toString(),
                                          totalPoint: totalPoint,
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                        duration:
                                            const Duration(milliseconds: 500)));
                              },
                              child: Text('$totalOrders',
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0)),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Total Finished Orders:',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: UserFinishedOrdersView(
                                      userName: userName,
                                      idUserMekanik: idUserMekanik,
                                      month: actualMonthChartOrders.toString(),
                                      year: actualYearChartOrders.toString(),
                                      totalPoint: totalPoint.toString(),
                                    ),
                                    type: PageTransitionType.rightToLeft,
                                    duration:
                                        const Duration(milliseconds: 500)),
                              );
                            },
                            child: Text('$totalUserOrdersFinished',
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.0)),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                child: UserFinishedOrdersView(
                                  userName: userName,
                                  idUserMekanik: idUserMekanik,
                                  month: actualMonthChartOrders.toString(),
                                  year: actualYearChartOrders.toString(),
                                  totalPoint: totalPoint.toString(),
                                ),
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 500)),
                          );
                        },
                        child: Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(24.0),
                            child: const Center(
                                child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.check,
                                  color: Colors.white, size: 30.0),
                            ))),
                      )
                    ]),
              ),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text('Total Canceled Orders:',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: UserCanceledOrdersView(
                                      userName: userName,
                                      idUserMekanik: idUserMekanik,
                                      month: actualMonthChartOrders.toString(),
                                      year: actualYearChartOrders.toString(),
                                    ),
                                    type: PageTransitionType.rightToLeft,
                                    duration:
                                        const Duration(milliseconds: 500)),
                              );
                            },
                            child: Text('$totalUserCanceledOrders',
                                style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.0)),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                child: UserCanceledOrdersView(
                                    userName: userName,
                                    idUserMekanik: idUserMekanik,
                                    month: actualMonthChartOrders.toString(),
                                    year: actualYearChartOrders.toString()),
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 500)),
                          );
                        },
                        child: Material(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(24.0),
                            child: const Center(
                                child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.cancel,
                                  color: Colors.white, size: 30.0),
                            ))),
                      )
                    ]),
              ),
            ),
            _buildTile(
              Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(bottom: 4.0)),
                      SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                              text: 'Monthly Finished Orders',
                              textStyle: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                          // Enable legend
                          legend: Legend(isVisible: false),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<UserFinishedOrders, String>>[
                            LineSeries<UserFinishedOrders, String>(
                                // dataSource: resUserFinishedOrders,
                                dataSource: dsUserFinishedOrders ?? [],
                                xValueMapper: (UserFinishedOrders fo, _) =>
                                    fo.day,
                                yValueMapper: (UserFinishedOrders fo, _) =>
                                    fo.countId,
                                name: 'Finished Orders',
                                color: Colors.green,
                                animationDuration: 2500,
                                // Enable data label
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true))
                          ]),
                    ],
                  )),
            ),
            _buildTile(
              Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(bottom: 4.0)),
                      SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                              text: 'Monthly Canceled Orders',
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                          // Enable legend
                          legend: Legend(isVisible: false),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<UserCanceledOrders, String>>[
                            LineSeries<UserCanceledOrders, String>(
                                dataSource: dsUserCanceledOrders ?? [],
                                xValueMapper: (UserCanceledOrders fo, _) =>
                                    fo.day,
                                yValueMapper: (UserCanceledOrders fo, _) =>
                                    fo.countId,
                                name: 'Canceled Orders',
                                color: Colors.orange,
                                animationDuration: 750,
                                // Enable data label
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true))
                          ]),
                    ],
                  )),
            ),
          ],
          staggeredTiles: const [
            StaggeredTile.extent(2, 158.0),
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(2, 378.0),
            StaggeredTile.extent(2, 378.0),
          ],
        ));
  }

  Widget _buildTile(Widget child) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: const Color(0x802196F3),
      child: InkWell(
        // onTap: onTap != null
        //     ? () => onTap()
        //     : () {
        //         print('Belum...');
        //       },
        child: child,
      ),
    );
  }

  _deactiveUser() async {
    String id = await SessionManager().getIdUser();
    final res = await authBloc.deactiveUser(id);

    bool? status = res['status'];
    if (status == true) {
      ShowToast().showToastSuccess('Log Out berhasil.');

      SessionManager().removeSession();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigation()),
          (route) => false);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/authBloc.dart';
import 'package:go_mekanik/bloc/orderBloc.dart';
import 'package:go_mekanik/components/bottom_nav_bar.dart';
import 'package:go_mekanik/screen/login/login.dart';
import 'package:go_mekanik/screen/machines_breakdown/machines_breakdown_page.dart';
// import 'package:go_mekanik/screen/machines_breakdown/scan_barcode_page.dart';
import 'package:go_mekanik/screen/transaksi/scan_barcode2.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:go_mekanik/util/ShowToast.dart';

class HomePage extends StatefulWidget {
  final String? idUser;
  const HomePage({super.key, required this.idUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // @override
  // void initState() {
  //   _getIdUser();
  //   super.initState();
  // }

  // _getIdUser() async {
  //   String? id = await SessionManager().getIdUser();
  //   setState(() {
  //     _idUser = id;
  //   });
  // }

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      MachinesBreakdownPage(idUser: widget.idUser),
      // const ScanBarcodePage()
      ScanBarcode2(idUser: widget.idUser)
    ];
    orderBloc.getByIdUser(widget.idUser);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          )),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // logo
                DrawerHeader(
                    child: Image.asset('assets/images/gomekanik_logo2.png')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Divider(
                    color: Colors.grey[800],
                  ),
                ),

                //other page
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: Text(
                      'About',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => _deactiveUser()),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
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
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false);
    }
  }
}

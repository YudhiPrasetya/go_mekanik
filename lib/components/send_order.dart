import 'package:flutter/material.dart';
import 'package:go_mekanik/bloc/masalahMesinBloc.dart';
import 'package:go_mekanik/bloc/orderBloc.dart';
import 'package:go_mekanik/model/masalahMesinModel.dart';
import 'package:go_mekanik/screen/machines_breakdown/home_page.dart';
import 'package:go_mekanik/util/SessionManager.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:page_transition/page_transition.dart';

class SendOrder extends StatefulWidget {
  final String? barcode;
  final String idUser;
  const SendOrder({super.key, this.barcode, required this.idUser});

  @override
  State<SendOrder> createState() => _SendOrderState();
}

class _SendOrderState extends State<SendOrder> {
  late List<MultiSelectItem<MasalahMesinModel?>> _masalahMesinItems;
  List<MasalahMesinModel?> _selectedMslhMesin = [];
  bool _isLoading = false;
  int _countSelectedMslhMesin = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Pilih Masalah Mesin'),
        FutureBuilder(
            future: masalahMesinBloc.getMasalahMesinAll(),
            builder: (BuildContext context,
                AsyncSnapshot<List<MasalahMesinModel>> snapshot) {
              Widget result;
              if (snapshot.hasData) {
                _masalahMesinItems = snapshot.data!
                    .map((m) => MultiSelectItem<MasalahMesinModel>(
                        m, m.masalahMesin.toString()))
                    .toList();
                result = Wrap(
                  spacing: 5.0,
                  children: [
                    MultiSelectDialogField(
                      items: _masalahMesinItems,
                      title: const Text('Masalah Mesin'),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          border: Border.all(color: Colors.blue, width: 2)),
                      buttonIcon: const Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                      searchable: true,
                      onConfirm: (values) {
                        setState(() {
                          _countSelectedMslhMesin = values.length;
                        });
                        _selectedMslhMesin = values;
                      },
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                result = Text('Error: ${snapshot.error}');
              } else {
                result = const Text('Loading...');
              }
              return result;
            }),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.red,
                    ))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white),
                      child: const Text(
                        'Send',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _countSelectedMslhMesin <= 0
                          ? null
                          : () async {
                              _sendNewMB();
                            }),
            )
          ],
        )
      ],
    );
  }

  _sendNewMB() async {
    setState(() {
      _isLoading = true;
    });
    String mslhMesins = "";
    for (var element in _selectedMslhMesin) {
      mslhMesins += element!.masalahMesin.toString() + ", ";
    }

    // String? idUser = await SessionManager().getIdUser();
    final resOrder = await orderBloc.tambahMachineBreakdown(
        widget.barcode, widget.idUser, mslhMesins);
    bool? statusOrder = resOrder['status'];

    if (statusOrder == true) {
      var showToast = ShowToast();
      showToast.showToastSuccess('Order berhasil ditambahkan');

      setState(() {
        _isLoading = false;
      });
      // back to MB List
      _backToHomePage();
    }
  }

  _backToHomePage() {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: HomePage(
              idUser: widget.idUser,
            ),
            type: PageTransitionType.leftToRight,
            duration: const Duration(milliseconds: 1000)),
        (route) => false);
  }
}

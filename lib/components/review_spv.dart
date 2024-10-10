import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_mekanik/bloc/machineSettledBloc.dart';
import 'package:go_mekanik/screen/machines_breakdown/home_page.dart';
import 'package:go_mekanik/util/ShowToast.dart';
import 'package:page_transition/page_transition.dart';

class ReviewSPV extends StatefulWidget {
  final String? machineBarcode;
  final String? idUser;
  const ReviewSPV({super.key, this.machineBarcode, this.idUser});

  @override
  State<ReviewSPV> createState() => _ReviewSPVState();
}

class _ReviewSPVState extends State<ReviewSPV> {
  final TextEditingController catatanSPVController = TextEditingController();
  double? rating = 0;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10.0),
        TextField(
          controller: catatanSPVController,
          decoration: const InputDecoration(hintText: 'Catatan SPV...'),
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Text('Rating Kinerja Mekanik'),
        const SizedBox(
          height: 5.0,
        ),
        RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rt) {
            rating = rt.toDouble();
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white),
                  child: const Text(
                    'Send',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _approved();
                  }),
        )
      ],
    );
  }

  _approved() async {
    setState(() {
      _isLoading = true;
    });
    double r = 2 * rating!;
    final rs = await machineSettledBloc.simpanMachineSettled(
        widget.machineBarcode!, catatanSPVController.text, r);
    if (rs['status'] == true) {
      setState(() {
        _isLoading = false;
      });
      // ShowToast().showToastSuccess('Berhasil');
      // back to MB list
      _backToHomePage();
    } else {
      ShowToast().showToastError('Gagal! ${rs['message']}');
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

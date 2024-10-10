import 'package:flutter/material.dart';

class HeaderServisMesinDetail extends StatelessWidget {
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

  const HeaderServisMesinDetail({
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Brand',
            style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
          RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontFamily: 'Varela',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
                text: '$merk'),
          ),
          const SizedBox(
            height: 10.0,
          ),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: 'Serial Number \n',
                  style: TextStyle(fontFamily: 'Varela', fontSize: 12.0)),
              TextSpan(
                text: '$noSeri',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Varela'),
              ),
            ]),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: 'Jenis Mesin \n',
                      style: TextStyle(fontFamily: 'Varela', fontSize: 12.0)),
                  TextSpan(
                    text: '$jenis',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Varela'),
                  ),
                ]),
              ),
              const SizedBox(width: 20.0),
              // SizedBox(width: 10.0),
              Expanded(
                child: Hero(
                  tag: idServisMesin!,
                  child: Container(
                    height: 175.0,
                    decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/' +
                                '$jenis'.toLowerCase() +
                                '.jpg'),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(32.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3.0,
                              blurRadius: 5.0)
                        ]),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

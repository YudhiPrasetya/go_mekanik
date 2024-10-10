import 'package:flutter/material.dart';

class HeaderQCODetail extends StatelessWidget {
  final String? idQCODetail;
  final String? status;
  final String? line;
  final String? merk;
  final String? jenisBarang;
  final String? noSeri;

  const HeaderQCODetail(
      {Key? key,
      this.idQCODetail,
      this.status,
      this.line,
      this.merk,
      this.jenisBarang,
      this.noSeri})
      : super(key: key);

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
                    text: '$jenisBarang',
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
                  tag: idQCODetail.toString(),
                  child: Container(
                    height: 175.0,
                    decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/' +
                                '$jenisBarang'.toLowerCase() +
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

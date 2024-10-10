import 'package:flutter/material.dart';

class HeaderDetail extends StatelessWidget {
  final String? idMachineBreakdown;
  final String? status;
  final String? line;
  final String? machineBrand;
  final String? machineType;
  final String? type;
  final String? machineSN;

  const HeaderDetail({
    Key? key,
    this.idMachineBreakdown,
    this.status,
    this.line,
    this.machineBrand,
    this.machineType,
    this.type,
    this.machineSN,
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
                text: '$machineBrand'),
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
                text: '$machineSN',
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
                    text: '$machineType',
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
                  tag: idMachineBreakdown.toString(),
                  child: Container(
                    height: 175.0,
                    decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/' +
                                '$machineType'.toLowerCase() +
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

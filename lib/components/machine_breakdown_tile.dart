import 'package:flutter/material.dart';
import 'package:go_mekanik/model/orderModel.dart';

class MachineBreakdownTile extends StatelessWidget {
  final OrderModel machineBreakdown;
  const MachineBreakdownTile({super.key, required this.machineBreakdown});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(25),
                  width: double.infinity,
                  child: Image.asset("assets/images/zz.jpg"),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                machineBreakdown.machineBrand.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                machineBreakdown.machineBrand.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          )
        ],
      ),
    );
  }
}

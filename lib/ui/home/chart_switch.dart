import 'package:flutter/material.dart';

class ChartSwitch extends StatelessWidget {
  final String label;
  final bool activated;
  final Function showChart;

  final double height;

  ChartSwitch(this.label, this.activated, this.showChart, this.height);

  @override
  Widget build(context) => Container(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            Switch(
              value: activated,
              onChanged: (val) => showChart(val),
            ),
          ],
        ),
      );
}

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double total;
  final double percentageOfTotal;

  ChartBar(this.day, this.total, this.percentageOfTotal);

  @override
  Widget build(context) => LayoutBuilder(
        builder: (ctx, constraints) => Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text("\$${total.toStringAsFixed(0)}")),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColorLight, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentageOfTotal,
                    alignment: Alignment.center,
                    widthFactor: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 1),
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(height: constraints.maxHeight * 0.15, child: Text(day))
          ],
        ),
      );
}

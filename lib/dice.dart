import 'package:flutter/material.dart';

class DiceBuilder extends StatelessWidget {
  final int dotNumber;
  const DiceBuilder(this.dotNumber, context);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          color: Theme.of(context).disabledColor,
          elevation: 5,
          shadowColor: Theme.of(context).shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
          ),
          child: dotBuilder(context, dotNumber),
        ),
      ),
    );
  }

  Widget dotBuilder(context, dotNumber) {
    var gridSize = 0;
    var dotCount = 0;
    while (dotNumber > dotCount) {
      gridSize++;
      dotCount = gridSize * gridSize;
    }
    //print('grid size $gridSize');
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridSize,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
      physics: NeverScrollableScrollPhysics(),
      children: List<Widget>.generate(
        dotNumber,
        (index) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}

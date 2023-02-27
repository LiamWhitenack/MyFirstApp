import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyWidget(),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: nineCards(),
    );
  }
}

List<Widget> nineCards() {
  List<int> numList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<Widget> output = [];
  int value = 42;
  int i = 0;
  for (int ele in numList) {
    output.add(
      Card(
        child: InkWell(
          onTap: () {
            value = i;
          },
          child: Container(
            color: value == i ? Colors.blue : Colors.grey,
            child: Text('element: $ele'),
          ),
        ),
      ),
    );
    i++;
  }
  return output;
}

import 'package:flutter/material.dart';

class Day extends StatelessWidget {
  const Day({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Napi előrejelzés'),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(14)),
                child: const Column(
                  children: [
                    Text('idő'),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.sunny,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('fok'),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
